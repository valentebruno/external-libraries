#!/bin/bash -e

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd build/vc12
devenv //Upgrade glew.sln
msbuild.exe glew_static.vcxproj //p:Configuration=Debug;Platform=${BUILD_ARCH}
msbuild.exe glew_static.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}
cd ../..

mkdir -p ${ins_dir}/lib
cp lib/*/*/* ${ins_dir}/lib/
cp -r include ${ins_dir}
cp -r doc ${ins_dir}
