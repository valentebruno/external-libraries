#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-android64
CROSS_COMPILER_PREFIX=/opt/android-standalone-toolchain-4.9-aarch64/bin/aarch64-linux-android-
SYSROOT=/opt/android-standalone-toolchain-4.9-aarch64/sysroot
HOST_NAME=aarch64-linux-android
CROSS_COMPILE_EXE_TYPE=64

# Protocol Buffers (protobuf)
# ===========================
ZLIB_VERSION="1.2.8"

PROTOBUF_VERSION="3.0.0-beta-2"
rm -f protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
wget https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfz protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
cd protobuf-${PROTOBUF_VERSION}

./configure --verbose --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --enable-static --disable-shared --with-zlib --with-protoc=/opt/local/Libraries-x64/protobuf-${PROTOBUF_VERSION}/bin/protoc CC=${CROSS_COMPILER_PREFIX}gcc CXX=${CROSS_COMPILER_PREFIX}g++ CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -fvisibility-inlines-hidden" CPPFLAGS="-I${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/include" LDFLAGS="-L${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/lib"
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..
ln -s ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION} ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VER_ALIAS}

