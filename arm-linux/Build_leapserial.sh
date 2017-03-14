#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""


# leapserial
# ========

LEAPSERIAL_VERSION=0.3.1
rm -fr leapserial
git clone git@github.com:leapmotion/leapserial.git
cd leapserial
git checkout v${LEAPSERIAL_VERSION}
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=~/platform/toolchain-arm64.cmake -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/leapserial-${LEAPSERIAL_VERSION}" ..
make -j4 install
cd ../..
