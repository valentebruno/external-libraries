#!/bin/bash -e

source_dir=$1
install_dir=$2

cd src/${source_dir}

devenv CyAPI.vcxproj //upgrade
msbuild.exe CyAPI.vcxproj //p:Configuration=Debug;Platform=${BUILD_ARCH}
msbuild.exe CyAPI.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}

mkdir -p ${install_dir}/inc && cp -r inc/Cy*.h "$_"
mkdir -p ${install_dir}/lib/${BUILD_ARCH} && cp -r ${BUILD_ARCH}/{Debug,Release} "$_"
