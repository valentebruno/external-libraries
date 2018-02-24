#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=${PWD}/Libraries-rk1108
CROSS_COMPILER_PREFIX=arm-linux-

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# glew
# ====

GLEW_VERSION="1.9.0"
wget https://sourceforge.net/projects/glew/files/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.tgz
rm -fr glew-${GLEW_VERSION}
tar xfz glew-${GLEW_VERSION}.tgz
cd glew-${GLEW_VERSION}
GLEW_DEST="${EXTERNAL_LIBRARY_DIR}/glew-${GLEW_VERSION}" make CC=${CROSS_COMPILER_PREFIX}gcc LD=${CROSS_COMPILER_PREFIX}ld CFLAGS.EXTRA=-fPIC STRIP=${CROSS_COMPILER_PREFIX}strip install
cd ..
