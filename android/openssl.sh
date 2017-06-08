#!/bin/bash -e
# OpenSSL
# =======

OPENSSL_OS="linux-aarch64"
export cfg_args="no-asm enable-static-engine"

if [[ $BUILD_ARCH == x86 ]]; then
  OPENSSL_OS="linux-generic32"
fi

source posix/$(basename $0)
