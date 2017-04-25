#!/bin/bash

# zlib
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CC=aarch64-linux-gnu-gcc \
CFLAGS="-fPIC -O3 -fvisibility=hidden -fvisibility-inlines-hidden" \
./configure --prefix="${ins_dir}" --static
make -j8 && make install
