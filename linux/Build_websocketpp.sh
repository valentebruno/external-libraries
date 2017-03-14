#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# Boost 1.55
# ==========

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"

# websocketpp
# ===========
#
# FIXME: We now use https://github.com/leapmotion/websocketpp/commits/leap

rm -fr websocketpp
git clone https://github.com/zaphoyd/websocketpp.git
cd websocketpp
git checkout -b version a6d2c325b16ebdbd5b2e746f9a9692176ccf218d
patch -p0 <<"BOOST_LOCK_GUARD"
--- src/messages/data.hpp
+++ src/messages/data.hpp
@@ -37,6 +37,7 @@
 #include <boost/function.hpp>
 #include <boost/intrusive_ptr.hpp>
 #include <boost/thread/mutex.hpp>
+#include <boost/thread/lock_guard.hpp>
 #include <boost/utility.hpp>
 
 #include <algorithm>
BOOST_LOCK_GUARD
patch -p0 <<"FPIC"
--- Makefile
+++ Makefile
@@ -51,7 +51,7 @@
 ifeq ($(OS), Darwin)
 	cxxflags_default = -c $(CPP11_) -Wall -O2 -DNDEBUG -I$(BOOST_INCLUDE_PATH)
 else
-	cxxflags_default = -c -Wall -O2 -DNDEBUG -I$(BOOST_INCLUDE_PATH)
+	cxxflags_default = -c -Wall -O2 -DNDEBUG -I$(BOOST_INCLUDE_PATH) -fPIC
 endif
 cxxflags_small   = -c 
 cxxflags_debug   = -c -g -O0
FPIC
CXX=arm-linux-gnueabihf-g++ BOOST_PREFIX="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" prefix="${EXTERNAL_LIBRARY_DIR}/websocketpp" make install
cd ..
