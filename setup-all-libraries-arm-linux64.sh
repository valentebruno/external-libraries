#!/bin/bash -e

export EXT_LIB_INSTALL_ROOT="${EXT_LIB_INSTALL_ROOT:-$(cd ..; pwd)/Libraries-arm64}"

source log-output.sh

export BUILD_TYPE=arm-linux
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

source setup-all-libraries-posix.sh

#For now, we depend on the jdk being located exactly here
if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/jdk ]]; then
  echo "Copying JDK..."
  cp -r /usr/lib/jvm/java-8-openjdk-arm64 ${EXT_LIB_INSTALL_ROOT}/jdk
fi

