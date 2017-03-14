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

# zlib
# ====

ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
CFLAGS="--sysroot=${SYSROOT} -fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" \
CXXFLAGS="--sysroot=${SYSROOT} -fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" \
LDFLAGS="--sysroot=${SYSROOT}" \
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..
rm -rf zlib-${ZLIB_VERSION}
rm -rf zlib-${ZLIB_VERSION}.tar.gz

