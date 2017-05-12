#!/bin/bash -e
# OpenSSL
# =======

if [ "${BUILD_ARCH}" == "x64" ]; then
  OPENSSL_OS="linux-x86_64"
else
  OPENSSL_OS="linux-generic32"
fi

export cfg_args="no-asm enable-static-engine"

source posix/$(basename $0)
