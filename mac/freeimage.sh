#!/bin/bash -e
# FreeImage
# =========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

export PREFIX=${ins_dir}
make -f Makefile.osx -j 4 && make -f Makefile.osx install
