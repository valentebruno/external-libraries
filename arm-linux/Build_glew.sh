#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

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
GLEW_DEST="${EXTERNAL_LIBRARY_DIR}/glew-${GLEW_VERSION}" make CC=aarch64-linux-gnu-gcc LD=aarch64-linux-gnu-gcc CFLAGS.EXTRA=-fPIC STRIP=aarch64-linux-gnu-strip install
cd ..
