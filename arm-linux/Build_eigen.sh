#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# Eigen
# =====

EIGEN_VERSION="3.2.1"
EIGEN_HASH="6b38706d90a9"
curl -O https://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.bz2
rm -fr eigen-eigen-${EIGEN_HASH}
tar xfj ${EIGEN_VERSION}.tar.bz2
mkdir -p "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported"
cp -R eigen-eigen-${EIGEN_HASH}/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/"
cp -R eigen-eigen-${EIGEN_HASH}/unsupported/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported/"

