#!/bin/bash -e
# For a build environment, see linux-build-env/Dockerfile.xenial-android64

export EXT_LIB_INSTALL_ROOT="${EXT_LIB_INSTALL_ROOT:-$(cd ..; pwd)/Libraries-android32}"
source log-output.sh

export BUILD_TYPE=android
export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x86
export ARCH_FLAGS="-march=armv7-a -mfpu=neon"

export HOST=arm-linux-androideabi
if [[ -z "${NDK_TOOLCHAIN}" ]]; then
	export NDK_TOOLCHAIN=/opt/local/android-standalone-toolchain
fi
export CROSS_COMPILER_PATH=${NDK_TOOLCHAIN}/bin
export PATH=$CROSS_COMPILER_PATH:$PATH
export CROSS_COMPILER_PREFIX=${HOST}-
export CC=${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}gcc
export CXX=${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}g++
export SYSROOT=${NDK_TOOLCHAIN}/sysroot
export CFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden ${ARCH_FLAGS}"
export LDFLAGS="-latomic"

export TOOLCHAIN_FILE=$(pwd)/toolchain-android32.cmake
export SKIP_QT_BUILD=true
export SKIP_SWIG_BUILD=true
export SKIP_PYTHON=true

export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

#override the libusb branch
source setup-library.sh
setup-library git@github.com:leapmotion/libusb.git 1.0.1 -g -b leap-2.3.x-arm

export SKIP_QT_BUILD=true
source setup-all-libraries-posix.sh
