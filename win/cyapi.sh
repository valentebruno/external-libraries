#!/bin/bash

source_dir=${BUILD_DIR}/$1
install_dir=$2

cd ${source_dir}

platform=${BUILD_ARCH}
if [[ ${BUILD_ARCH} == x86 ]]; then
  platform=Win32
fi

devenv CyAPI.vcxproj //upgrade
msbuild.exe CyAPI.vcxproj //p:Configuration=Debug;Platform=${platform}
msbuild.exe CyAPI.vcxproj //p:Configuration=Release;Platform=${platform}

mkdir -p ${install_dir}/inc && cp -r inc/Cy*.h "$_"

local_build_dir=${platform}
if [[ ${BUILD_ARCH} == x86 ]]; then
  local_build_dir=.
fi
mkdir -p ${install_dir}/lib/${BUILD_ARCH} && cp -r ${local_build_dir}/{Debug,Release} "$_"
