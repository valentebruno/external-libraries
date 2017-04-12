#!/bin/bash

# zlib
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./configure --static --prefix="${ins_dir}"
CFLAGS="-arch x86_64" make -j8
make install