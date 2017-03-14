#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-x64

# libusb
# ======

rm -fr libusb
git clone --branch leap-2.2.x https://github.com/leapmotion/libusb.git
cd libusb
./bootstrap.sh
./configure --disable-udev CFLAGS="-O3 ${ARCH_FLAGS}"
make
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so
cd ..

# libuvc
# ======

rm -fr libuvc
git clone http://sf-github.leap.corp/leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb" -DCMAKE_C_FLAGS="-fPIC -O3"
make && make install
cd ..
rm -fr Build
cd ..

