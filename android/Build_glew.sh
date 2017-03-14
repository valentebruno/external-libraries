#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# glew
# ====

GLEW_VERSION="1.9.0"
curl -O http://iweb.dl.sourceforge.net/project/glew/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.tgz
rm -fr glew-${GLEW_VERSION}
tar xfz glew-${GLEW_VERSION}.tgz
cd glew-${GLEW_VERSION}
GLEW_DEST="${EXTERNAL_LIBRARY_DIR}/glew-${GLEW_VERSION}" make CC=arm-linux-gnueabihf-gcc LD=arm-linux-gnueabihf-gcc CFLAGS.EXTRA=-fPIC STRIP=arm-linux-gnueabihf-strip install
cd ..
