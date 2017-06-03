#!/bin/bash -e
src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}" -DSDL_STATIC:BOOL=ON -DSDL_SHARED:BOOL=FALSE -DCMAKE_DEBUG_POSTFIX:STRING="d"
