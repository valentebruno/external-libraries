#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-x86
ARCH_FLAGS="-m32"

# zlib
# ====

ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CFLAGS="-fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden ${ARCH_FLAGS}" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..

