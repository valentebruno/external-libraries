#!/bin/bash -e
# zlib
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./configure --static --prefix="${ins_dir}" ${cfg_args}

make -j8 && make install
