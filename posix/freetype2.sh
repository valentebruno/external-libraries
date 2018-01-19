#!/bin/bash -e
# Freetype
# ========

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}
./autogen.sh

./configure --prefix="${ins_dir}" --without-zlib --without-bzip2 \
 --without-png ${cfg_args}

make -j 9 && make install
cp docs/FTL.TXT "${ins_dir}"/
