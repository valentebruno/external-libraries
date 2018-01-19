#!/bin/bash -e

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

cd build/cmake

build_cmake_lib "${ins_dir}" -DBUILD_UTILS:BOOL=FALSE -DBUILD_SHARED_LIBS:BOOL=FALSE
