#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

cd src

# Protocol Buffers (protobuf) [libc++]
# ====================================
PROTOBUF_VERSION="3.0.0-beta-2"
rm -f protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
wget https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfz protobuf-cpp-${PROTOBUF_VERSION}.tar.gz
cd protobuf-${PROTOBUF_VERSION}

./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}-libc++" --enable-static --disable-shared --with-zlib CXX=clang++ CXXFLAGS="-O3 -D_THREAD_SAFE -mmacosx-version-min=10.7 -arch x86_64 -arch i386 -stdlib=libc++ -fvisibility=hidden -fvisibility-inlines-hidden" CPPFLAGS="-I${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/include" LDFLAGS="-L${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/lib"
make -j 4 && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}-libc++"; ln -s include src)
cd ..
ln -s ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}-libc++ ${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VER_ALIAS}-libc++

cd ..
