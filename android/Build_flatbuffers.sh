#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

#Build on host first

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} -DFLATBUFFERS_BUILD_TESTS:BOOL=OFF

make -j 9 VERBOSE=1 && make install
