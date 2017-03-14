#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64-TX1-alt
export LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib
export SYSROOT=/opt/sysroot/TX1-alt

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""


# leapserial
# ========

LEAPSERIAL_VERSION=0.3.2
rm -fr leapserial
git clone http://github.com/leapmotion/leapserial.git
cd leapserial
git checkout v${LEAPSERIAL_VERSION}
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=/opt/local/toolchain-arm64-TX1.cmake -DCMAKE_C_FLAGS="-fPIC -O3 --sysroot=${SYSROOT}" -DCMAKE_CXX_FLAGS="-fPIC -O3 --sysroot=${SYSROOT}" -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/leapserial-${LEAPSERIAL_VERSION}" ..
make -j4 install
cd ../..
