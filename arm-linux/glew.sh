#!/bin/bash -e
# GLEW
# ====

echo "Building GLEW"
src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p b
cd b

cmake ../build/cmake -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} \
 -DBUILD_UTILS:BOOL=OFF ${CMAKE_ADDITIONAL_ARGS}

cmake --build . --target install --config Release
