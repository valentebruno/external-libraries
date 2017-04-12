#!/bin/bash

# LeapSerial
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} \
-DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.10" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386"
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
