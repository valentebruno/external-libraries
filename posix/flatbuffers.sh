#!/bin/bash
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -DFLATBUFFERS_BUILD_TESTS:BOOL=OFF -DCMAKE_CXX_STANDARD:STRING=11
