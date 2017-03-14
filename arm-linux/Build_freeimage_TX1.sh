#!/bin/bash -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64-TX1-alt
CROSS_COMPILER_PREFIX=/opt/sysroot/TX1-alt/usr/bin/aarch64-linux-gnu-
# FreeImage
# =========

FREEIMAGE_VERSION="3.16.0"
FREEIMAGE_ZIP=FreeImage${FREEIMAGE_VERSION//./}.zip
if [ ! -f ${FREEIMAGE_ZIP} ]; then
  curl -O http://iweb.dl.sourceforge.net/project/freeimage/Source%20Distribution/${FREEIMAGE_VERSION}/${FREEIMAGE_ZIP}
fi
rm -fr FreeImage
unzip -x ${FREEIMAGE_ZIP}
cd FreeImage

LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib \
  CC=${CROSS_COMPILER_PREFIX}gcc \
  CXX=${CROSS_COMPILER_PREFIX}g++ \
  CXXFLAGS="--sysroot=/opt/sysroot/TX1-alt" \
  INSTALLDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/lib" \
  PREFIX="${EXTERNAL_LIBRARY_DIR}/FreeImage" DESTDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage" \
  INCDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/include" make

LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib \
  CC=${CROSS_COMPILER_PREFIX}gcc \
  CXX=${CROSS_COMPILER_PREFIX}g++ \
  CXXFLAGS="--sysroot=/opt/sysroot/TX1-alt" \
  INSTALLDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/lib" \
  PREFIX="${EXTERNAL_LIBRARY_DIR}/FreeImage" DESTDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage" \
  INCDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/include" make install

