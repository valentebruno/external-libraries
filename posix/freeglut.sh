#!/bin/bash -e
# freeglut
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}" -DFREEGLUT_BUILD_DEMOS:BOOL=OFF \
-DFREEGLUT_BUILD_SHARED_LIBS:BOOL=OFF -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=ON -DINSTALL_PDB:BOOL=OFF
