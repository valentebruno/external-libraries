#!/bin/bash

# zlib
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./configure --prefix="${ins_dir}" --static
make -j8 && make install
