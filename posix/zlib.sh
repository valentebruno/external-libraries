#!/bin/bash -e
# zlib
# ====
src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

./configure --static --prefix="${ins_dir}" ${cfg_args}

make_check_err -j8 && make_check_err install

