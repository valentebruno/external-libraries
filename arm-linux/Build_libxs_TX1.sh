#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64-TX1-alt
CROSS_COMPILER_PREFIX=/opt/sysroot/TX1-alt/usr/bin/aarch64-linux-gnu-

# Crossroads (libxs)
# ==================

XS_VERSION="1.2.0"
rm -fr libxs
git clone --depth 1 --branch leap https://github.com/leapmotion/libxs.git
cd libxs
./autogen.sh
LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib \
./configure --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}/libxs-${XS_VERSION}" --enable-static --disable-shared CC=${CROSS_COMPILER_PREFIX}gcc CXX=${CROSS_COMPILER_PREFIX}g++ CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE --sysroot=/opt/sysroot/TX1-alt"
make && make install
cd ..

