#!/bin/bash
src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -DSDL_STATIC:BOOL=ON -DSDL_SHARED:BOOL=FALSE -DCMAKE_DEBUG_POSTFIX:STRING="d" -DHAVE_LIBC:BOOL=1
