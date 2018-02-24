#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# nanosvg
# =======

rm -fr nanosvg
git clone https://github.com/memononen/nanosvg
cd nanosvg
mkdir -p ${EXTERNAL_LIBRARY_DIR}/nanosvg/include
cp src/*.h ${EXTERNAL_LIBRARY_DIR}/nanosvg/include/
cp LICENSE.txt ${EXTERNAL_LIBRARY_DIR}/nanosvg/
cd ..

