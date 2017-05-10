#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX=${ins_dir} ${CMAKE_ADDITIONAL_ARGS} -DFLATBUFFERS_BUILD_TESTS:BOOL=OFF

make -j 9 && make install
