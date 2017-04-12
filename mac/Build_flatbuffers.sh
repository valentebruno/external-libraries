#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CXXFLAGS="-stdlib=libc++ -fvisibility=hidden" cmake . -DCMAKE_INSTALL_PREFIX=${ins_dir} \
-DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.10"
cmake --build . --target install --config debug
cmake --build . --target install --config release
