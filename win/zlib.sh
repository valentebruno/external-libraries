#!/bin/bash -e
# zlib
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -DBUILD_SHARED_LIBS:BOOL=OFF
