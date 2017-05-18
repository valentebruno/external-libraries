#!/bin/bash -e
# zlib
# ====

if [ "${BUILD_ARCH}" == "x64" ]; then
  export cfg_args=--64
fi

source posix/$(basename $0)
