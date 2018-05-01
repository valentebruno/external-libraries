#!/bin/bash -e
# For a build environment, see linux-build-env/Dockerfile.xenial-android64

export EXT_LIB_INSTALL_ROOT="${EXT_LIB_INSTALL_ROOT:-$(cd ..; pwd)/Libraries-android64}"
source log-output.sh

export BUILD_TYPE=android
export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x64
export ARCH_FLAGS=

export HOST=aarch64-linux-android
if [[ -z "${ANDROID_STANDALONE_TOOLCHAIN}" ]]; then
	export ANDROID_STANDALONE_TOOLCHAIN=/opt/local/android-standalone-toolchain
fi
export CROSS_COMPILER_PATH=${ANDROID_STANDALONE_TOOLCHAIN}/bin
export PATH=$CROSS_COMPILER_PATH:$PATH
export CROSS_COMPILER_PREFIX=${HOST}-
export CC=${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}clang
export CXX=${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}clang++
export SYSROOT=${ANDROID_STANDALONE_TOOLCHAIN}/sysroot
export CFLAGS="-pie -O3 -fvisibility=hidden -fvisibility-inlines-hidden"
export LDFLAGS="-latomic"

export TOOLCHAIN_FILE=$(pwd)/toolchain-android64.cmake
export SKIP_QT_BUILD=true
export SKIP_SWIG_BUILD=true
export SKIP_PYTHON=true

export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

source setup-all-libraries-posix.sh
