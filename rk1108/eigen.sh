#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# Eigen
# =====
EIGEN_VERSION="3.2.1"
EIGEN_HASH=6b38706d90a9
curl -O https://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.bz2
tar xfj ${EIGEN_VERSION}.tar.bz2
rm -rf ${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}
mkdir -p "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported"
cp -R eigen-eigen-${EIGEN_HASH}/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/"
cp -R eigen-eigen-${EIGEN_HASH}/unsupported/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported/"
rm -rf ${EIGEN_VERSION}.tar.bz2
rm -rf eigen-eigen-${EIGEN_HASH}

