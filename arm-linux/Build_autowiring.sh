#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""


# autowiring
# ========

AUTOWIRING_VERSION=0.7.8
rm -fr autowiring
git clone git@github.com:leapmotion/autowiring.git
cd autowiring
git checkout v${AUTOWIRING_VERSION}
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=~/platform/toolchain-arm64.cmake -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/autowiring-${AUTOWIRING_VERSION}" ..
make -j4 install
cd ../..
