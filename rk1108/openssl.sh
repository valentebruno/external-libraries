#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

OPENSSL_VERSION="1.0.1u"
wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
rm -fr openssl-${OPENSSL_VERSION}
tar xfz openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
if [ "${MACHINE}" == "x86_64" ]; then
  OPENSSL_OS="linux-x86_64"
else
  OPENSSL_OS="linux-generic32"
fi
CC=${CROSS_COMPILER_PREFIX}gcc LD=${CROSS_COMPILER_PREFIX}ld AS=${CROSS_COMPILER_PREFIX}as AR=${CROSS_COMPILER_PREFIX}ar ./Configure -fPIC --prefix="${EXTERNAL_LIBRARY_DIR}/openssl" ${OPENSSL_OS} no-asm enable-static-engine
make -k || true
make -k install || true
cd ..

