#!/bin/bash -e
# FreeImage
# =========

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

export PREFIX=${ins_dir}
make_check_err -f Makefile.osx -j 4 && make_check_err -f Makefile.osx install
