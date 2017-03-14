#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

cd src

# libusb
# ======

LIBUSB_ORIGIN="git@sf-github.leap.corp:leapmotion/libusb.git" # https://github.com/leapmotion/libusb.git

# libuvc
# ======

rm -fr libuvc
git clone git@sf-github.leap.corp:leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
CXXFLAGS="-stdlib=libc++" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.7 -DCMAKE_OSX_SYSROOT:PATH=macosx10.9 -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb"
make && make install
cd ..
rm -fr Build
cd ..

cd ..
