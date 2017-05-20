#!/bin/bash
export BUILD_TYPE=arm-linux
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-arm64"

export BUILD_ARCH=x64

export TOOLCHAIN_FILE=$(pwd)/toolchain-arm64.cmake
export CROSS_COMPILER_PREFIX=/usr/bin/aarch64-linux-gnu-
export CROSS_COMPILER_VERSION=5
export HOST="aarch64-linux-gnu"
export CC=${CROSS_COMPILER_PREFIX}gcc-${CROSS_COMPILER_VERSION}
export CXX=${CROSS_COMPILER_PREFIX}g++-${CROSS_COMPILER_VERSION}
export AR=${CROSS_COMPILER_PREFIX}gcc-ar-${CROSS_COMPILER_VERSION}
export LD=${CROSS_COMPILER_PREFIX}ld
export STRIP=${CROSS_COMPILER_PREFIX}strip

export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

#override the libusb branch
source setup-library.sh
setup-library https://github.com/leapmotion/libusb.git 1.0.0 -g -b leap-2.3.x-arm

source setup-all-libraries-posix.sh
