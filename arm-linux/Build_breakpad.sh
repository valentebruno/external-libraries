#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""


# Breakpad
# ========

BREAKPAD_VERSION=0.1
rm -fr breakpad-${BREAKPAD_VERSION}
svn checkout http://google-breakpad.googlecode.com/svn/trunk/ breakpad-${BREAKPAD_VERSION}
cd breakpad-${BREAKPAD_VERSION}
BREAKPAD_FLAGS=""
./configure CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}"/breakpad-${BREAKPAD_VERSION} ${BREAKPAD_FLAGS}
make && make install
BREAKPAD_INCLUDE="${EXTERNAL_LIBRARY_DIR}/breakpad-${BREAKPAD_VERSION}/include"
cd src
for f in $(find client common google_breakpad processor testing third_party -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
cd ../..
