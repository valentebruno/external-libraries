#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32
CROSS_COMPILER_PREFIX=/usr/bin/arm-linux-gnueabihf-
HOST="arm-linux-gnueabihf"

HOST_NAME=arm-linux-gnueabihf
CROSS_COMPILE_EXE_TYPE=64

# Protocol Buffers (protobuf)
# ===========================
PROTOBUF_VERSION="2.5.0"
curl -O http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VERSION}.tar.bz2
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfj protobuf-${PROTOBUF_VERSION}.tar.bz2
cd protobuf-${PROTOBUF_VERSION}
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden"
make && make install
cd protobuf-${PROTOBUF_VERSION}
mkdir ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}/bin-${CROSS_COMPILE_EXE_TYPE}
cp  ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}/bin/protoc ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}/bin-${CROSS_COMPILE_EXE_TYPE}/

cd ..
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfj protobuf-${PROTOBUF_VERSION}.tar.bz2
cd protobuf-${PROTOBUF_VERSION}
CXX=${CROSS_COMPILER_PREFIX}g++ \
LDFLAGS="-L/usr/lib/arm-linux-gnueabihf" \
CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -fvisibility-inlines-hidden" \
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --host=${HOST_NAME} --enable-static --disable-shared  --with-protoc=${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}/bin-${CROSS_COMPILE_EXE_TYPE}/protoc
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..
rm -rf protobuf-${PROTOBUF_VERSION}
rm -rf protobuf-${PROTOBUF_VERSION}.tar.bz2

