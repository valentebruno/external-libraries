#!/bin/bash
export BUILD_TYPE=arm-linux
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-arm64"
export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x64
export ARCH_FLAGS=


export TOOLCHAIN_FILE=$(pwd)/toolchain-arm64.cmake
export CROSS_COMPILER_PREFIX=/usr/bin/aarch64-linux-gnu-
export CROSS_COMPILER_VERSION=5
export HOST="aarch64-linux-gnu"
export CC=${CROSS_COMPILER_PREFIX}gcc-${CROSS_COMPILER_VERSION}
export CXX=${CROSS_COMPILER_PREFIX}g++-${CROSS_COMPILER_VERSION}
export AR=${CROSS_COMPILER_PREFIX}gcc-ar-${CROSS_COMPILER_VERSION}
export LD=${CROSS_COMPILER_PREFIX}ld

#32 bit - /usr/bin/arm-linux-gnueabihf-

source setup-library.sh

#required for bullet
setup-library http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz 3.0.0 -s "freeglut-3.0.0" -o "freeglut-3.0.0" -n "freeglut"

source setup-all-libraries.sh
setup-library git://code.qt.io/qt/qt5.git 5.8.0 -o "qt-5.8.0"

SWIG_VERSION=3.0.3
setup-library http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz ${SWIG_VERSION} -s "swig-${SWIG_VERSION}" -o "swig-${SWIG_VERSION}" -n "swig"

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library https://github.com/leapmotion/libusb.git 1.0.0 -g -b leap-2.2.x
setup-library http://sf-github.leap.corp/leapmotion/libuvc.git 1.0.0 -g -b "master"
