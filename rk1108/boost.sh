#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

#EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-rk1108
EXTERNAL_LIBRARY_DIR=${PWD}/Libraries-rk1108

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# Boost 1.55
# ==========

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"
#rm -f boost_${BOOST_VERSION}.tar.bz2
#wget "http://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2"
rm -fr boost_${BOOST_VERSION}
tar xfj "boost_${BOOST_VERSION}.tar.bz2"
cd boost_${BOOST_VERSION}
patch -p1 tools/build/v2/user-config.jam <<EOF
--- user-config.jam.old 2016-03-03 15:25:18.634622974 -0800
+++ user-config.jam     2016-03-03 15:25:08.690373194 -0800
@@ -1,3 +1,5 @@
+using gcc : arm : arm-linux-g++ ;
+
 # Copyright 2003, 2005 Douglas Gregor
 # Copyright 2004 John Maddock
 # Copyright 2002, 2003, 2004, 2007 Vladimir Prus
EOF
rm -fr /tmp/boost
./bootstrap.sh
./b2 --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" --build-dir=/tmp link=static threading=multi variant=release cflags="-fPIC" cxxflags="-fPIC" toolset=gcc-arm target-os=linux --without-mpi --without-python install
cd ..
