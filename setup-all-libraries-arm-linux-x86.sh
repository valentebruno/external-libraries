#!/bin/bash

export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-arm32"
source log-output.sh

export BUILD_TYPE=arm-linux
export BUILD_ARCH=x64

export TOOLCHAIN_PATH=/opt/rk1108_toolchain/usr/bin
export PATH=$TOOLCHAIN_PATH:$PATH
export CROSS_COMPILER_PREFIX=$TOOLCHAIN_PATH/arm-rkcvr-linux-uclibcgnueabihf-
export CROSS_COMPILER_VERSION=4.8.5
export CC=${CROSS_COMPILER_PREFIX}gcc-${CROSS_COMPILER_VERSION}
export CXX=${CROSS_COMPILER_PREFIX}g++
export AR=${CROSS_COMPILER_PREFIX}gcc-ar
export LD=${CROSS_COMPILER_PREFIX}ld
export STRIP=${CROSS_COMPILER_PREFIX}strip

source setup-all-libraries-posix.sh
