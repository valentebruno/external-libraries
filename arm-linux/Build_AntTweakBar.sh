#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# AntTweakBar
# ===========

#rm -fr AntTweakBar
#git clone --branch sdl20 git@github.com:leapmotion/anttweakbar.git AntTweakBar
cd AntTweakBar/src
make CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ LINK=aarch64-linux-gnu-gcc CXXCFG="-O3 -fpermissive"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
cp -R ../include/* "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include/"
cp ../lib/libAntTweakBar.so "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
(cd "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"; ln -s libAntTweakBar.so libAntTweakBar.so.1)
cd ../..
