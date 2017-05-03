#!/bin/bash

# Autowiring
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CXXFLAGS=-fPIC

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} -DAutowiring_DEBUG:BOOL=ON -DVERBOSE:BOOL=ON
cmake --build . --target install --config Debug -- -j8
cmake --build . --target install --config Release -- -j8
