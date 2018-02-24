#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# zlib
# ====
ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
FLAGS="--sysroot=${RK1108_SYSROOT}" \
CXXFLAGS="--sysroot=${RK1108_SYSROOT}" \
LDFLAGS="--sysroot=${RK1108_SYSROOT}" \
CFLAGS="-fPIC -O3" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..

