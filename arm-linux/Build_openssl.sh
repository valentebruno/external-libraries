#!/bin/bash -e
# OpenSSL
# =======

if [ "${BUILD_ARCH}" == "x64" ]; then
  export OPENSSL_OS="linux-aarch64"
else
  export OPENSSL_OS="linux-generic32"
fi

export CC=${CC##${CROSS_COMPILER_PREFIX}}
export cfg_args="no-asm enable-static-engine"
source posix/$(basename $0)
