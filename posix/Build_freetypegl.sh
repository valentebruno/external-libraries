#!/bin/bash -e
# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}" -DFREETYPE_INCLUDE_DIRS="${FREETYPE2_PATH}/include/freetype2" \
-DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.a" \
-Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF \
-Dfreetype-gl_BUILD_MAKEFONT=OFF -Dfreetype-gl_BUILD_TESTS:BOOL=OFF

mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp libfreetype-gl* "${ins_dir}/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${ins_dir}/include/"
