#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain/bin/arm-linux-androideabi-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-android.cmake
HOST_NAME=arm-linux-androideabi
BOOST_TOOLSET=gcc-android
CROSS_COMPILE_EXE_TYPE=32
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-android${CROSS_COMPILE_EXE_TYPE}

# libusb
# ======
rm -rf libusb
git clone --branch leap-2.3.x-arm https://github.com/leapmotion/libusb.git
cd libusb
./bootstrap.sh
CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
CFLAGS="--sysroot=/opt/android-standalone-toolchain/sysroot" \
CXXFLAGS="--sysroot=/opt/android-standalone-toolchain/sysroot" \
LDFLAGS="--sysroot=/opt/android-standalone-toolchain/sysroot" \
./configure -v --host=${HOST_NAME} CFLAGS="-Ofast" --disable-udev --disable-log
patch -p1 libtool < ../soname.diffs
make
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so
cd ..
rm -rf libusb

# libuvc
# ======
rm -fr libuvc
git clone --branch fix-uvc_stop-deadlock git@sf-github.leap.corp:leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb" -DLIBUSB_INCLUDE_DIR="${EXTERNAL_LIBRARY_DIR}/libusb/include" -DLIBUSB_LIBRARY_NAMES="${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so" -DCMAKE_C_FLAGS="-fPIC -Ofast" -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} 
make && make install
cd ..
rm -fr Build
cd ..
rm -rf libuvc
