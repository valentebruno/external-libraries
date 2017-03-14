#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32
CROSS_COMPILER_PREFIX=/usr/bin/arm-linux-gnueabihf-
HOST="arm-linux-gnueabihf"

# zlib
# ====

ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
CFLAGS="-fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" \
CXXFLAGS="-fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" \
LDFLAGS="-L/usr/lib/arm-linux-gnueabihf" \
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..
rm -rf zlib-${ZLIB_VERSION}
rm -rf zlib-${ZLIB_VERSION}.tar.gz

