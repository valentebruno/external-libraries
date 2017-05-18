#!/bin/bash -e
# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DFREETYPE_INCLUDE_DIRS="${FREETYPE2_PATH}/include/freetype2" \
-DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.a" \
-Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF \
-Dfreetype-gl_BUILD_MAKEFONT=OFF \
${CMAKE_ADDITIONAL_ARGS}

make -j 9
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp libfreetype-gl.a "${ins_dir}/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${ins_dir}/include/"
