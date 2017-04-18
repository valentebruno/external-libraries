#!/bin/bash

# LeapSerial
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir}
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
