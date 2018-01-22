#!/bin/bash
# OpenSSL
# =======

OPENSSL_OS="linux-generic64 -DB_ENDIAN"
export cfg_args="no-asm enable-static-engine"

if [[ $BUILD_ARCH == x86 ]]; then
  OPENSSL_OS="linux-generic32"
fi

source posix/$(basename $0)
