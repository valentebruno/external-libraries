#!/bin/bash -e
# Breakpad
# =================

export CXXFLAGS="${CXXFLAGS} -include endian.h"
export BREAKPAD_FLAGS="--host=${HOST}"

if [[ ${BUILD_ARCH} == x86 ]]; then
  export BREAKPAD_FLAGS="${BREAKPAD_FLAGS} --disable-processor --disable-tools"
fi

#remove patch for older NDK version
if [[ ${BUILD_ARCH} == x64 ]]; then
  rm "src/$1/src/common/android/include/sys/user.h"
else
  rm "src/$1/src/common/android/testing/include/wchar.h"
  rm "src/$1/src/common/android/include/link.h"
  sed -i 's/sys_mmap2/sys_mmap/g' "src/$1/src/common/memory.h"
  sed -i 's/sys_mmap2/sys_mmap/g' "src/$1/src/common/linux/memory_mapped_file.cc"
fi

source posix/$(basename $0)

