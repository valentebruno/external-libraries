#!/bin/bash -e
# Autowiring
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}"
