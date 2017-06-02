#!/bin/bash -e
src_dir=$1
ins_dir=$2
cd src/${src_dir}

devenv //Upgrade FreeImage.2013.sln
msbuild.exe Source/FreeImageLib/FreeImageLib.2013.vcxproj //p:Configuration=Debug;Platform=${BUILD_ARCH}
msbuild.exe Source/FreeImageLib/FreeImageLib.2013.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}

mkdir -p ${ins_dir}/include && cp Source/FreeImage.h "$_"
mkdir -p ${ins_dir}/lib && cp Dist/*/FreeImageLib*.lib "$_"
