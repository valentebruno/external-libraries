#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=${PWD}/Libraries-rk1108

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# libusb
# ======

rm -fr libusb
git clone --branch leap-2.2.x http://github.com/leapmotion/libusb.git
cd libusb
./bootstrap.sh
./configure --host=arm-linux --disable-udev CC=arm-linux-gcc CFLAGS="-O3 ${ARCH_FLAGS}"
make
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so
cd ..

