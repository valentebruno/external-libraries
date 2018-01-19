#!/bin/bash -e

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}

cp -r ${src_dir} ${ins_dir}
