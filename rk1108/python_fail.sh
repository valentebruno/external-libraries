#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# Python
# ======

PYTHON_VERSION="2.7.11"
PYTHON_VERSION_MAJOR_MINOR="2.7"
curl -O https://www.python.org/ftp/python/2.7.11/Python-${PYTHON_VERSION}.tgz
rm -fr Python-${PYTHON_VERSION}
tar xfz Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}
cat > config.site <<"CONFIG"
ac_cv_file__dev_ptmx=no
ac_cv_file__dev_ptc=no
CONFIG
./configure --host=${HOST_NAME} --build=i686-pc-linux-gnu CC=${CROSS_COMPILER_PREFIX}gcc CXX=${CROSS_COMPILER_PREFIX}g++ --prefix="${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}" --disable-shared --disable-ipv6 CFLAGS="-fPIC" CPPFLAGS="-fPIC" LDFLAGS="-fPIC" CONFIG_SITE=config.site
make -j 4 && make install
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/bin"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/share"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/lib/python${PYTHON_VERSION_MAJOR_MINOR}"
cd ..
