#!/bin/bash -e
# LeapSerial
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} ${CMAKE_ADDITIONAL_ARGS}
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
