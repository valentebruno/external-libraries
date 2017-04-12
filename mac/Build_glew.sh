# glew
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

patch -p0 <<"GLEW_MAC_BUILD_PATCH"
--- Makefile  2012-08-06 08:59:08.000000000 -0700
+++ Makefile  2012-11-08 11:14:50.000000000 -0800
@@ -61,6 +61,8 @@
 #   - use LN= on gmake command-line

 AR      ?= ar
+ARFLAGS ?= cr
+RANLIB  ?= ranlib
 INSTALL ?= install
 STRIP   ?= strip
 RM      ?= rm -f
@@ -100,7 +102,7 @@
  mkdir lib

 lib/$(LIB.STATIC): $(LIB.OBJS)
- $(AR) cr $@ $^
+ $(AR) $(ARFLAGS) $@ $^
 ifneq ($(STRIP),)
  $(STRIP) -x $@
 endif
@@ -139,7 +141,7 @@
 glew.lib.mx:  lib lib/$(LIB.SHARED.MX) lib/$(LIB.STATIC.MX) glewmx.pc

 lib/$(LIB.STATIC.MX): $(LIB.OBJS.MX)
- $(AR) cr $@ $^
+ $(AR) $(ARFLAGS) $@ $^

 lib/$(LIB.SHARED.MX): $(LIB.SOBJS.MX)
  $(LD) $(LDFLAGS.SO.MX) -o $@ $^ $(LIB.LDFLAGS) $(LIB.LIBS)
--- config/Makefile.darwin  2012-08-06 08:59:08.000000000 -0700
+++ config/Makefile.darwin  2012-11-08 11:18:25.000000000 -0800
@@ -1,10 +1,10 @@
 NAME = $(GLEW_NAME)
 CC = cc
 LD = cc
-CFLAGS.EXTRA = -dynamic -fno-common
+CFLAGS.EXTRA = -arch x86_64 -dynamic -fno-common
 #CFLAGS.EXTRA += -no-cpp-precomp
 PICFLAG = -fPIC
-LDFLAGS.EXTRA =
+LDFLAGS.EXTRA = -arch x86_64
 ifneq (undefined, $(origin GLEW_APPLE_GLX))
 CFLAGS.EXTRA += -I/usr/X11R6/include -D'GLEW_APPLE_GLX'
 LDFLAGS.GL = -L/usr/X11R6/lib -lXmu -lXi -lGL -lXext -lX11
GLEW_MAC_BUILD_PATCH
GLEW_DEST="${ins_dir}" AR=libtool ARFLAGS=-o make install
cd ..

