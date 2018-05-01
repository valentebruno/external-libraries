#!/bin/bash -e
# FreeImage
# =========

export CFLAGS="${CFLAGS} -DPNG_ARM_NEON_OPT=0"
export CFLAGS="${CFLAGS} -I${NDK_ROOT}/sources/android/cpufeatures"

source posix/$(basename $0)
