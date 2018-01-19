#!/bin/bash -e
# Breakpad
# =================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

BREAKPAD_DIR="${ins_dir}"
BREAKPAD_INCLUDE="${BREAKPAD_DIR}/include"
BREAKPAD_BIN="${BREAKPAD_DIR}/bin"
BREAKPAD_LIB="${BREAKPAD_DIR}/lib"

CC=clang CXX=clang++ CFLAGS="-O3 -arch x86_64"  CXXFLAGS="-O3 -arch x86_64 -stdlib=libc++" ./configure --prefix="${BREAKPAD_DIR}"
make -j 4 && make install

cd src
for f in $(find client common google_breakpad processor testing -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
cd ..

xcodebuild -project src/tools/mac/dump_syms/dump_syms.xcodeproj -destination 'platform=OS X' GCC_VERSION=com.apple.compilers.llvm.clang.1_0 MACOSX_DEPLOYMENT_TARGET=10.10 OTHER_CPLUSPLUSFLAGS="-stdlib=libc++" OTHER_LDFLAGS="-stdlib=libc++"
xcodebuild -project src/client/mac/Breakpad.xcodeproj -destination 'platform=OS X' -target Breakpad GCC_VERSION=com.apple.compilers.llvm.clang.1_0 MACOSX_DEPLOYMENT_TARGET=10.10 OTHER_CPLUSPLUSFLAGS="-stdlib=libc++" OTHER_LDFLAGS="-stdlib=libc++"

cp src/tools/mac/dump_syms/build/Release/dump_syms "${BREAKPAD_DIR}/bin/"
cp -R src/tools/mac/dump_syms/build/Release/dump_syms.dSYM "${BREAKPAD_DIR}/bin/"
cp -R src/client/mac/build/Release/Breakpad.framework "${BREAKPAD_DIR}/lib/"
cd ..
