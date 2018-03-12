#!/bin/bash
# For a build environment, see linux-build-env/Dockerfile.xenial-android64

export EXT_LIB_INSTALL_ROOT="${EXT_LIB_INSTALL_ROOT:-$(cd ..; pwd)/Libraries-android64}"
source log-output.sh

export BUILD_TYPE=android
export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x64
export ARCH_FLAGS=

export HOST=aarch64-linux-android
export CROSS_COMPILER_PREFIX=${HOST}-
export CC=${NDK_TOOLCHAIN}/bin/clang
export CXX=${NDK_TOOLCHAIN}/bin/clang++
export SYSROOT=${NDK_TOOLCHAIN}/sysroot
export CFLAGS="-O3 -fvisibility=hidden -fvisibility-inlines-hidden"
export LDFLAGS="-static-libstdc++"

export TOOLCHAIN_FILE=$(pwd)/toolchain-android64.cmake
export SKIP_QT_BUILD=true
export SKIP_SWIG_BUILD=true
export SKIP_PYTHON=true

export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

#override the libusb branch
source setup-library.sh
setup-library git@github.com:leapmotion/libusb.git 1.0.0 -g -b leap-2.3.x-arm

source setup-all-libraries-posix.sh
