#!/bin/bash -e
# AntTweakBar
# ====================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

cd src
CXXCFG="-O3"
if [ ${BUILD_TYPE} != "mac" ]; then
  CXXCFG="${CXXCFG} -fpermissive"
fi
make_check_err -j 4 CXXCFG="${CXXCFG}" ${make_args}
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp -R ../include/* "${ins_dir}/include/"
cp ../lib/libAntTweakBar.a "${ins_dir}/lib"
