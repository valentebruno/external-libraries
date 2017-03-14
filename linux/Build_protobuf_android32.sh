#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-android32
CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain/bin/arm-linux-androideabi-
SYSROOT=/opt/android-standalone-toolchain/sysroot
HOST_NAME=arm-linux-androideabi
CROSS_COMPILE_EXE_TYPE=64

# Protocol Buffers (protobuf)
# ===========================
PROTOBUF_VERSION="3.0.0-beta-2"
PROTOBUF_VER_ALIAS="3.0.0.2"
rm -f protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
wget https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfz protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
cd protobuf-${PROTOBUF_VERSION}

CC=${CROSS_COMPILER_PREFIX}gcc \
CXX=${CROSS_COMPILER_PREFIX}g++ \
FLAGS="--sysroot=${SYSROOT}" \
CXXFLAGS="--sysroot=${SYSROOT}" \
LDFLAGS="--sysroot=${SYSROOT}" \
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --host=${HOST_NAME} --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -fvisibility-inlines-hidden" --with-protoc=/opt/local/Libraries-x64/protobuf-${PROTOBUF_VERSION}/bin/protoc
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..
rm -rf protobuf-${PROTOBUF_VERSION}
rm -rf protobuf-${PROTOBUF_VERSION}.tar.gz2
ln -s ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION} ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VER_ALIAS}

