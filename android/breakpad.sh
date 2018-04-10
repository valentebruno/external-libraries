#!/bin/bash -e
# Breakpad
# =================

export CXXFLAGS="${CXXFLAGS} -include string.h"
export BREAKPAD_FLAGS="--host=${HOST} --disable-processor --disable-tools"

#_src_root="${BUILD_DIR}/$1/src"
#remove patch for older NDK version
#if [[ ${BUILD_ARCH} == x64 ]]; then
  #rm -f "${_src_root}/common/android/include/sys/user.h"
#else
  #rm -f "${_src_root}/common/android/testing/include/wchar.h"
  #rm -f "${_src_root}/common/android/include/link.h"
  #sed -i 's/sys_mmap2/sys_mmap/g' "${_src_root}/common/memory.h"
  #sed -i 's/sys_mmap2/sys_mmap/g' "${_src_root}/common/linux/memory_mapped_file.cc"
#fi

source posix/$(basename $0)
