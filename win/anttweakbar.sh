#!/bin/bash
src_dir=$1
install_dir=$2

cd ${BUILD_DIR}/${src_dir}

cd src
devenv //Upgrade AntTweakBar_VS2012.sln
msbuild.exe AntTweakBar.vcxproj //p:Configuration=Debug;Platform=${BUILD_ARCH}
msbuild.exe AntTweakBar.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}
cd ..

mkdir -p ${install_dir}
cp -r {include,lib} "$_"
