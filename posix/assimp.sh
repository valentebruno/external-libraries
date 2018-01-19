#!/bin/bash -e
# assimp
# ======

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

#Assimp's custom find module always locates the wrong version and doesn't respect ZLIB_ROOT
rm -f cmake-modules/FindZLIB.cmake

build_cmake_lib "${ins_dir}" -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON \
-DASSIMP_BUILD_TESTS=OFF -DZLIB_ROOT:PATH=${ZLIB_PATH}
