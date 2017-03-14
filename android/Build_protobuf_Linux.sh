#!/bin/sh
# Build and install all of the Leap dependent libraries

if [ $1 = "x86" ]; then
  ARCH_FLAGS="-m32"
elif [ $1 = "x64" ]; then
  ARCH_FLAGS=""
fi
EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-$1

# Protocol Buffers (protobuf)
# ===========================
PROTOBUF_VERSION="3.0.0-beta-2"
rm -f protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
wget https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfz protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
cd protobuf-${PROTOBUF_VERSION}

./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -fvisibility-inlines-hidden ${ARCH_FLAGS}"
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..

