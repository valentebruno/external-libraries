#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# freeglut
# ========

FREEGLUT_VERSION="2.8.0"
curl -O http://iweb.dl.sourceforge.net/project/freeglut/freeglut/${FREEGLUT_VERSION}/freeglut-${FREEGLUT_VERSION}.tar.gz
rm -fr freeglut-${FREEGLUT_VERSION}
tar xfz freeglut-${FREEGLUT_VERSION}.tar.gz
cd freeglut-${FREEGLUT_VERSION}
patch -p0 <<"FREEGLUT_NO_XRANDR_XF86VM"
--- configure.old	2013-02-12 13:02:05.517823000 -0800
+++ configure	2013-02-12 13:00:48.160776000 -0800
@@ -12229,6 +12229,7 @@
 else
   ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 fi
+ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12274,6 +12275,7 @@
 else
   ac_cv_lib_Xrandr_XRRQueryExtension=no
 fi
+ac_cv_lib_Xrandr_XRRQueryExtension=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12550,6 +12552,8 @@
 $as_echo "#define TIME_WITH_SYS_TIME 1" >>confdefs.h
 
 fi
+ac_cv_header_X11_extensions_xf86vmode_h=no
+ac_cv_header_X11_extensions_Xrandr_h=no
 
 for ac_header in X11/extensions/xf86vmode.h
 do :
FREEGLUT_NO_XRANDR_XF86VM
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ ./configure --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}" CPPFLAGS="-fPIC"
make && make install
cd ..
# required one fix to some header isssue with glext.h, just had to match their const-ness
