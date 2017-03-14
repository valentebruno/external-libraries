#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CC=aarch64-linux-gnu-gcc CFLAGS="-fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..
