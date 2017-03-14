#!/bin/sh
# Build and install all of the Leap dependent libraries

#EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-android$1
EXTERNAL_LIBRARY_DIR=/home/hham/Projects/libusb/Libraries-android$1
if [ $1 = "64" ]; then
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain-4.9-aarch64/bin/aarch64-linux-android-
  SYSROOT=/opt/android-standalone-toolchain-4.9-aarch64/sysroot
else
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain/bin/arm-linux-androideabi-
  SYSROOT=/opt/android-standalone-toolchain/sysroot
fi

CUR_DIR=${PWD}
HOST_NAME=arm-linux-androideabi

# libusb
# ======
#rm -rf libusb
#git clone --branch leap-2.2.x https://github.com/leapmotion/libusb.git
#git clone --branch non-hotplug-linux https://github.com/leapmotion/libusb.git
cd libusb
./bootstrap.sh
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
CFLAGS="--sysroot=${SYSROOT}" \
CXXFLAGS="--sysroot=${SYSROOT}" \
LDFLAGS="--sysroot=${SYSROOT} -llog -landroid" \
./configure -v --host=${HOST_NAME} CFLAGS="-O3 -DLIBUSB_DEBUG=4" LDFLAGS="--sysroot=${SYSROOT} -llog" --disable-udev --enable-debug-log
#--disable-log
patch -p1 libtool < ../soname.diffs
make
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so
cd ..
