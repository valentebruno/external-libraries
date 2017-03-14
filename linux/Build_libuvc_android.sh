#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
if [ $1 = "64" ]; then
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain-4.9-aarch64/bin/aarch64-linux-android-
  HOST_NAME=aarch64-linux-android
  TOOLCHAIN_FILE=${CUR_DIR}/toolchain-android64.cmake
else
  CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain/bin/arm-linux-androideabi-
  HOST_NAME=arm-linux-android
  TOOLCHAIN_FILE=${CUR_DIR}/toolchain-android.cmake
fi
CROSS_COMPILE_EXE_TYPE=$1
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-android${CROSS_COMPILE_EXE_TYPE}

# libuvc
# ======
rm -fr libuvc
git clone --branch master git@sf-github.leap.corp:leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb" -DLIBUSB_INCLUDE_DIR="${EXTERNAL_LIBRARY_DIR}/libusb/include" -DLIBUSB_LIBRARY_NAMES="${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so" -DCMAKE_C_FLAGS="-fPIC -Ofast" -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} 
make && make install
cd ..
rm -fr Build
cd ..
rm -rf libuvc
