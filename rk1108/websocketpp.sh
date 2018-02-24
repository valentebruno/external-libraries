#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux
CUR_DIR=${PWD}

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# Boost 1.55
# ==========

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"

# websocketpp
# ===========
#
# FIXME: We now use https://github.com/leapmotion/websocketpp/commits/leap
WEBSOCKETPP_VERSION="0.7.0"
rm -fr websocketpp
git clone https://github.com/zaphoyd/websocketpp.git
cd websocketpp
git checkout 0.7.0
rm -rf Build
mkdir -p Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/websocketpp-${WEBSOCKETPP_VERSION}" -DCMAKE_C_FLAGS="-fPIC -O3" -DCMAKE_CXX_FLAGS="-fPIC -O3" -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} -DBOOST_ROOT="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}"
make install
cd ..
rm -fr Build
cd ..
rm -rf websocketpp

