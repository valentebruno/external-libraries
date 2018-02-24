#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# Crossroads (libxs)
# ==================
XS_VERSION="1.2.0"
rm -fr libxs
git clone --depth 1 --branch leap https://github.com/leapmotion/libxs.git
cd libxs
./autogen.sh
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
FLAGS="--sysroot=${RK1108_SYSROOT}" \
CXXFLAGS="--sysroot=${RK1108_SYSROOT}" \
LDFLAGS="--sysroot=${RK1108_SYSROOT}" \
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/libxs-${XS_VERSION}" --host=${HOST_NAME} --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE"
make && make install
cd ..
rm -rf libxs

