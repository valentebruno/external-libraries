#!/bin/bash -e

# http://zxstudio.org/blog/2014/10/28/integrating-google-breakpad/

src_dir=$1
ins_dir=$2
cd src/${src_dir}

if [[ ! -d gyp ]]; then
  git clone --depth 1 https://chromium.googlesource.com/external/gyp
fi

export PATH=${PATH}:$(pwd)/gyp
export GYP_MSVS_VERSION=${VS_VER_YEAR}
GYP_ARGS="-d all --format=msvs --no-circular-check -D win_release_RuntimeLibrary=2 -D win_debug_RuntimeLibrary=2"
gyp ${GYP_ARGS} src/client/windows/breakpad_client.gyp
gyp ${GYP_ARGS} src/tools/windows/dump_syms/dump_syms.gyp
gyp ${GYP_ARGS} src/processor/processor.gyp

for CONFIG in Debug Release; do
  mkdir -p ${ins_dir}/lib/${CONFIG}

  msbuild.exe src/client/windows/handler/exception_handler.vcxproj //p:Configuration=${CONFIG};Platform=${BUILD_ARCH}
  cp src/client/windows/handler/${CONFIG}/lib/* ${ins_dir}/lib/${CONFIG}

  msbuild.exe src/client/windows/common.vcxproj //p:Configuration=${CONFIG};Platform=${BUILD_ARCH}
  cp src/client/windows/${CONFIG}/lib/* ${ins_dir}/lib/${CONFIG}

  msbuild.exe src/client/windows/crash_generation/crash_generation_client.vcxproj //p:Configuration=${CONFIG};Platform=${BUILD_ARCH}
  msbuild.exe src/client/windows/crash_generation/crash_generation_server.vcxproj //p:Configuration=${CONFIG};Platform=${BUILD_ARCH}
  cp src/client/windows/crash_generation/${CONFIG}/lib/* ${ins_dir}/lib/${CONFIG}

  msbuild.exe src/client/windows/sender/crash_report_sender.vcxproj //p:Configuration=${CONFIG};Platform=${BUILD_ARCH}
  cp src/client/windows/sender/${CONFIG}/lib/* ${ins_dir}/lib/${CONFIG}
done

msbuild.exe src/tools/windows/dump_syms/dump_syms.vcxproj //p:Configuration=Release;Platform=${BUILD_ARCH}
mkdir -p ${ins_dir}/bin && cp src/tools/windows/dump_syms/Release/dump_syms.exe "$_"

mkdir -p ${ins_dir}/include/client && cp src/client/*.h "$_"
mkdir -p ${ins_dir}/include/client/windows && cp src/client/windows/*/*.h "$_"
mkdir -p ${ins_dir}/include/common && cp src/common/*.h "$_"
mkdir -p ${ins_dir}/include/google_breakpad && cp src/google_breakpad/*/*.h "$_"
mkdir -p ${ins_dir}/include/processor && cp src/processor/*.h "$_"
