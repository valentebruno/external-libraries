#!/bin/bash -e
# assimp
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

#Assimp's custom find module always locates the wrong version and doesn't respect ZLIB_ROOT
rm -f cmake-modules/FindZLIB.cmake

mkdir -p build
cd build

cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON \
-DCMAKE_INSTALL_PREFIX="${ins_dir}" -DCMAKE_BUILD_TYPE:STRING=Release \
-DASSIMP_BUILD_TESTS=OFF -DZLIB_ROOT:PATH=${ZLIB_PATH} ${CMAKE_ADDITIONAL_ARGS}

make -j 9 && make install
