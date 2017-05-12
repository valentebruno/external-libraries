#!/bin/bash -e
# Autowiring
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} ${CMAKE_ADDITIONAL_ARGS}

cmake --build . --target install --config Debug -- -j8
cmake --build . --target install --config Release -- -j8
