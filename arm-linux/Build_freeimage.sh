#!/bin/bash -e
# FreeImage
# =========

export CFLAGS="${CFLAGS} -DPNG_ARM_NEON_OPT=0"
source posix/$(basename $0)
