#!/bin/bash
# freeglut
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX=${ins_dir} -DFREEGLUT_BUILD_DEMOS:BOOL=OFF \
-DFREEGLUT_BUILD_SHARED_LIBS:BOOL=OFF -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=ON ${CMAKE_ADDITIONAL_ARGS}

make -j 9 && make install
