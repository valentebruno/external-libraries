#!/bin/sh

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared --with-zlib \
CXX=clang++ CXXFLAGS="-O3 -D_THREAD_SAFE -mmacosx-version-min=10.10 -arch x86_64 -stdlib=libc++ -fvisibility=hidden -fvisibility-inlines-hidden" \
CPPFLAGS="-I${ZLIB_PATH}/include" LDFLAGS="-L${ZLIB_PATH}/lib -lz"
make -j 4 && make install
# Superceded: presumably no longer needed in 3.0+
# The build system looks in the src directory for include files. Make a link for now.
#(cd "${ins_dir}"; ln -s include src)

