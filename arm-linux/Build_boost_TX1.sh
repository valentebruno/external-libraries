#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64-TX1-alt
CROSS_COMPILER_PREFIX=/opt/sysroot/TX1-alt/usr/bin/aarch64-linux-gnu-
# Boost 1.55
# ==========
BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"
wget -O boost_${BOOST_VERSION}.tar.bz2 http://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2/download
rm -fr boost_${BOOST_VERSION}
tar xfj "boost_${BOOST_VERSION}.tar.bz2"
cd boost_${BOOST_VERSION}
patch -p1 tools/build/v2/user-config.jam <<EOF
--- user-config.jam.old 2016-03-03 15:25:18.634622974 -0800
+++ user-config.jam     2016-03-03 15:25:08.690373194 -0800
@@ -1,3 +1,5 @@
+using gcc : arm : aarch64-linux-gnu-g++ ;
+
 # Copyright 2003, 2005 Douglas Gregor
 # Copyright 2004 John Maddock
 # Copyright 2002, 2003, 2004, 2007 Vladimir Prus
EOF

rm -fr build/boost
mkdir build
mkdir build/boost


./bootstrap.sh --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" link=static threading=multi variant=release
LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib \
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
./b2 target-os=linux --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" --build-dir=./build link=static threading=multi variant=release cflags="-fPIC" cxxflags="-fPIC" --without-mpi --without-python install
cd ..
rm -rf boost_${BOOST_VERSION}
cd ${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}
ln -s include/boost boost
cd ${CUR_DIR}

