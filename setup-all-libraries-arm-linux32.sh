#!/bin/bash -e

export EXT_LIB_INSTALL_ROOT="${EXT_LIB_INSTALL_ROOT:-$(cd ..; pwd)/Libraries-arm32}"

source log-output.sh

export BUILD_TYPE=arm-linux
export BUILD_ARCH=armhf

export TOOLCHAIN_FILE=$(pwd)/toolchain-arm32.cmake
export CROSS_COMPILER_PREFIX=/usr/bin/arm-linux-gnueabihf-
export HOST="arm-linux-gnueabihf"
export CC=${CROSS_COMPILER_PREFIX}gcc
export CXX=${CROSS_COMPILER_PREFIX}g++
export AR=${CROSS_COMPILER_PREFIX}gcc-ar
export LD=${CROSS_COMPILER_PREFIX}ld
export STRIP=${CROSS_COMPILER_PREFIX}strip

export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

source setup-all-libraries-posix.sh

#For now, we depend on the jdk being located exactly here
if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/jdk ]]; then
  echo "Copying JDK..."
  cp -r /usr/lib/jvm/java-8-openjdk-armhf ${EXT_LIB_INSTALL_ROOT}/jdk
fi
