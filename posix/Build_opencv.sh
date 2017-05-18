#!/bin/bash -e
# OpenCV
# ======n

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake .. -DBUILD_DOCS:BOOL=OFF \
-DBUILD_PERF_TESTS:BOOL=OFF \
-DBUILD_TESTS:BOOL=OFF \
-DCMAKE_BUILD_TYPE:STRING=Release \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" \
-DEIGEN_INCLUDE_PATH:PATH="${EIGEN_PATH}" \
-DWITH_CUDA:BOOL=OFF \
-DWITH_MATLAB:BOOL=OFF \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DWITH_QT:BOOL=OFF \
${CMAKE_ADDITIONAL_ARGS}

make -j8 && make install
