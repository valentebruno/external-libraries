#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# FreeImage
# =========
FREEIMAGE_VERSION="3.16.0"
FREEIMAGE_VER=3160
wget -O FreeImage${FREEIMAGE_VER}.zip http://sourceforge.net/projects/freeimage/files/Source%20Distribution/${FREEIMAGE_VERSION}/FreeImage${FREEIMAGE_VER}.zip/download
rm -rf FreeImage
unzip FreeImage${FREEIMAGE_VER}.zip
cd FreeImage
patch Source/LibPNG/pngpriv.h ../pngpriv.patch

CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
CXXFLAGS="--sysroot=${RK1108_SYSROOT} -mfpu=neon -fPIC" \
make

sudo INSTALLDIR=${EXTERNAL_LIBRARY_DIR}/FreeImage/lib \
PREFIX=${EXTERNAL_LIBRARY_DIR}/FreeImage \
DESTDIR=${EXTERNAL_LIBRARY_DIR}/FreeImage \
INCDIR=${EXTERNAL_LIBRARY_DIR}/FreeImage/include make install
cd ..
rm -rf FreeImage
rm -rf FreeImage${FREEIMAGE_VER}.zip

