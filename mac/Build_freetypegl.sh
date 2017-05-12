#!/bin/bash -e
# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir build
cd build

export CMAKE_ADDITIONAL_ARGS="-Dfreetype-gl_BUILD_TESTS=OFF"

source posix/$(basename $0)
