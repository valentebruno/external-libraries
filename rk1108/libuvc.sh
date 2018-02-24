#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=${PWD}/Libraries-rk1108

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# libuvc
# ======
VERSION="1.0.1"

rm -fr libuvc
git clone -b upd-1.0.1 http://sf-github.leap.corp/leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
cmake .. -DCMAKE_TOOLCHAIN_FILE=~/Projects/making_libraries/toolchain-rk1108.cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc-${VERSION}" -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb" -DCMAKE_C_FLAGS="-fPIC -O3"
make
make install
cd ..
rm -fr Build
cd ..
rm -rf libuvc

