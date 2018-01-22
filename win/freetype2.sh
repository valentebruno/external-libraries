#!/bin/bash

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}"
