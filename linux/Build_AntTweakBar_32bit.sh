#!/bin/bash -xe

# AntTweakBar
# ===========

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-x86
rm -fr AntTweakBar
git clone -b static git@github.com:leapmotion/AntTweakBar.git
cd AntTweakBar/src
patch -p1 Makefile << "MYPATCH"
diff --git a/src/Makefile b/src/Makefile
index 19491de..e590c59 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -7,7 +7,7 @@ AR_EXT		= .a
 
 #---- Release
 CXXCFG   	= -O3
-LFLAGS		= 
+LFLAGS		= -m32
 OUT_DIR		= ../lib
 #---- Debug
 #CXXCFG   	= -g -D_DEBUG
@@ -16,7 +16,7 @@ OUT_DIR		= ../lib
 
 
 CXX      	= gcc
-CXXFLAGS 	= $(CXXCFG) -Wall -fPIC -fno-strict-aliasing -D_UNIX -D__PLACEMENT_NEW_INLINE
+CXXFLAGS 	= $(CXXCFG) -Wall -fPIC -fno-strict-aliasing -D_UNIX -D__PLACEMENT_NEW_INLINE -m32
 INCPATH  	= -I../include -I/usr/local/include -I/usr/X11R6/include -I/usr/include
 LINK     	= gcc
 #LIBS     	= -L/usr/X11R6/lib -L. -lglfw -lGL -lGLU -lX11 -lXxf86vm -lXext -lpthread -lm
MYPATCH
make
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
cp -R ../include/* "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include/"
cp ../lib/libAntTweakBar.so ../lib/libAntTweakBar.a "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
(cd "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"; ln -s libAntTweakBar.so libAntTweakBar.so.1)
cd ../..


