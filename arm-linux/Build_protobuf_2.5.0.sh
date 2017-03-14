#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

ZLIB_VERSION="1.2.8"

PROTOBUF_VERSION="2.5.0"
rm -fr protobuf
git clone http://github.com/google/protobuf.git
cd protobuf
#git checkout v${PROTOBUF_VERSION}
# Add aarch64 support
#git cherry-pick f0b6a5cfeb5f6347c34975446bda08e0c20c9902
git checkout 3aa5ea95a9f10cc64bcaeac47291913e52c3eac7
# need 64-bit atomics to actually work
./autogen.sh
patch -p1 src/google/protobuf/stubs/atomicops.h <<EOF
--- atomicops.h.old	2016-03-03 19:41:53.787385090 -0800
+++ atomicops.h	2016-03-03 19:39:59.920482941 -0800
@@ -176,7 +176,7 @@
 #elif defined(__GNUC__)
 #if defined(GOOGLE_PROTOBUF_ARCH_IA32) || defined(GOOGLE_PROTOBUF_ARCH_X64)
 #include <google/protobuf/stubs/atomicops_internals_x86_gcc.h>
-#elif defined(GOOGLE_PROTOBUF_ARCH_ARM)
+#elif defined(GOOGLE_PROTOBUF_ARCH_ARM) || defined(GOOGLE_PROTOBUF_ARCH_AARCH64)
 #include <google/protobuf/stubs/atomicops_internals_arm_gcc.h>
 #elif defined(GOOGLE_PROTOBUF_ARCH_ARM_QNX)
 #include <google/protobuf/stubs/atomicops_internals_arm_qnx.h>
EOF
./configure --verbose --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --enable-static --disable-shared --with-zlib --with-protoc=/opt/local/Libraries-x64/protobuf-${PROTOBUF_VERSION}/bin/protoc CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -fvisibility-inlines-hidden" CPPFLAGS="-I${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/include" LDFLAGS="-L${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/lib"
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..
