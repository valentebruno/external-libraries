#!/bin/bash

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

cd builds/msvc
devenv //Upgrade msvc12.sln
msbuild.exe libxs/libxs-vc12.vcxproj //p:Configuration=Debug;Platform=${BUILD_ARCH}
msbuild.exe libxs/libxs-vc12.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}
cd ../..

mkdir -p ${ins_dir}
cp -r doc ${ins_dir}
cp -r include ${ins_dir}
mkdir -p ${ins_dir}/lib && cp bin/*/*.lib "$_"
