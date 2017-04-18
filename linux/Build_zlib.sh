#!/bin/bash

# zlib
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}


CFLAGS="-fPIC -O3" ./configure --static --prefix="${ins_dir}" $( [ ${BUILD_ARCH} == x64 ] && echo --64 )

make -j8 && make install
