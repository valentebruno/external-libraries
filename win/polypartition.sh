#!/bin/bash
src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

mkdir -p build
cd build

cl //D_DEBUG //EHsc //MDd //c ../src/polypartition.cpp
lib polypartition.obj
mkdir -p ${ins_dir}/lib/debug && cp polypartition.lib "$_"

cl //EHsc //MD //c ../src/polypartition.cpp
lib polypartition.obj

mkdir -p ${ins_dir}/lib/release && cp polypartition.lib "$_"
mkdir -p ${ins_dir}/include && cp ../src/polypartition.h "$_"
