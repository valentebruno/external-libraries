#!/bin/bash -e
# glew
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

GLEW_DEST="${ins_dir}" make_check_err install
