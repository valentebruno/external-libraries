#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CXXFLAGS="-fPIC" cmake . -DCMAKE_INSTALL_PREFIX=${ins_dir}
make -j 9 && make install
