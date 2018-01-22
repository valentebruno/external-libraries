#!/bin/bash
# protobuf
# ====================================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}/cmake

build_cmake_lib "${ins_dir}" -Dprotobuf_BUILD_TESTS:BOOL=false \
 -Dprotobuf_MSVC_STATIC_RUNTIME:BOOL=false -Dprotobuf_WITH_ZLIB:BOOL=true \
 -DZLIB_ROOT:PATH="${ZLIB_PATH}"
