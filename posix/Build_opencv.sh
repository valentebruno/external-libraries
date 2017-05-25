#!/bin/bash -e
# OpenCV
# ======n

src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}" -DBUILD_DOCS:BOOL=OFF \
-DBUILD_PERF_TESTS:BOOL=OFF \
-DBUILD_TESTS:BOOL=OFF \
-DEIGEN_INCLUDE_PATH:PATH="${EIGEN_PATH}" \
-DWITH_CUDA:BOOL=OFF \
-DWITH_MATLAB:BOOL=OFF \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DWITH_QT:BOOL=OFF
