#!/bin/bash -e
# FreeImage
# =========

export CFLAGS="${CFLAGS} -DPNG_ARM_NEON_OPT=0"
if [[ $BUILD_ARCH == x86 ]]; then
  export CFLAGS="${CFLAGS} -I${NDK_ROOT}/sources/android/cpufeatures"
fi
source posix/$(basename $0)
