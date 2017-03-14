#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32

# SDL2
# ====

SDL2_VERSION="2.0.1"
if [ ! -f SDL2-${SDL2_VERSION}.tar.gz ]; then
  curl -O http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz
fi
rm -fr SDL2-${SDL2_VERSION}
tar xfz SDL2-${SDL2_VERSION}.tar.gz
cd SDL2-${SDL2_VERSION}
CC=arm-linux-gnueabihf-gcc CFLAGS="-fPIC" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/sdl2-${SDL2_VERSION}" --disable-shared -enable-static --disable-audio --disable-joystick --disable-haptic --host=arm-linux
make -j 4 install
cd ..
