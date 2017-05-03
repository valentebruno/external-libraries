#!/bin/bash
# For a build environment, see linux-build-env/Dockerfile.xenial-android64

export BUILD_TYPE=android
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-android64"
export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x64
export ARCH_FLAGS=

export HOST=aarch64-linux-android
export CROSS_COMPILER_PREFIX=${HOST}-
export CC=${NDK_TOOLCHAIN}/bin/clang
export CXX=${NDK_TOOLCHAIN}/bin/clang++
export SYSROOT=${NDK_TOOLCHAIN}/sysroot
export CFLAGS="-isystem $NDK_TOOLCHAIN/sysroot/usr/include/$HOST -O3 -fvisibility=hidden -fvisibility-inlines-hidden"
export LDFLAGS="-static-libstdc++"

export TOOLCHAIN_FILE=$(pwd)/toolchain-android64.cmake

source setup-library.sh

#required for bullet
setup-library http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz 3.0.0 -s "freeglut-3.0.0" -o "freeglut-3.0.0" -n "freeglut"

source setup-all-libraries.sh

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library https://github.com/leapmotion/libusb.git 1.0.0 -g -b leap-2.3.x-arm
setup-library http://sf-github.leap.corp/leapmotion/libuvc.git 1.0.0 -g -b "master"
