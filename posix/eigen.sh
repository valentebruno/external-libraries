#!/bin/bash
# Eigen
# ====

src_dir=$1
ins_dir=$2
mkdir -p ${ins_dir}/unsupported
cp -R ${BUILD_DIR}/${src_dir}/Eigen ${ins_dir}/
cp -R ${BUILD_DIR}/${src_dir}/unsupported/Eigen ${ins_dir}/unsupported/
