#!/bin/bash -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

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
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ INSTALLDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/lib" \
  PREFIX="${EXTERNAL_LIBRARY_DIR}/FreeImage" DESTDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage" \
  INCDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/include" make

CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ INSTALLDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/lib" \
  PREFIX="${EXTERNAL_LIBRARY_DIR}/FreeImage" DESTDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage" \
  INCDIR="${EXTERNAL_LIBRARY_DIR}/FreeImage/include" make install
cd ..
