#!/bin/bash

# Autowiring
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CXXFLAGS=-fPIC
cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir}

cmake --build . --target install --config Debug -- -j8
cmake --build . --target install --config Release -- -j8
