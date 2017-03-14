#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-android$1
if [ $1 = "64" ]; then
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain-4.9-aarch64/bin/aarch64-linux-android-
  SYSROOT=/opt/android-standalone-toolchain-4.9-aarch64/sysroot
else
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain-r10/bin/arm-linux-androideabi-
  SYSROOT=/opt/android-standalone-toolchain-r10/sysroot
fi

# bzip2
# =====

BZIP2_VERSION="1.0.6"
if [ ! -f bzip-${BZIP2_VERSION}.tar.gz ]; then
  curl -sLO http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz
fi
rm -fr bzip2-${BZIP2_VERSION}
tar xfz bzip2-${BZIP2_VERSION}.tar.gz
cd bzip2-${BZIP2_VERSION}
patch -p0 <<MAKEFILE_OPTIONS
--- Makefile	2016-07-07 12:59:14.181344400 -0700
+++ Makefile	2016-07-07 12:59:47.958115105 -0700
@@ -15,13 +15,14 @@
 SHELL=/bin/sh
 
 # To assist in cross-compiling
-CC=gcc
+CC=${CROSS_COMPILER_PREFIX}gcc
 AR=ar
 RANLIB=ranlib
 LDFLAGS=
 
 BIGFILES=-D_FILE_OFFSET_BITS=64
-CFLAGS=-Wall -Winline -O2 -g \$(BIGFILES)
+CFLAGS=-Wall -Winline \$(BIGFILES) -O3 -fvisibility=hidden -fPIC --sysroot="${SYSROOT}" -fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden
+LDFLAGS=--sysroot="${SYSROOT}"

 # Where you want it installed when you do 'make install'
 PREFIX=/usr/local
MAKEFILE_OPTIONS
make -j 4 libbz2.a bzip2 bzip2recover && sudo make install PREFIX="${EXTERNAL_LIBRARY_DIR}/bzip2-${BZIP2_VERSION}"
cd ..
