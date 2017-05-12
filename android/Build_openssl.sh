#!/bin/bash -e
# OpenSSL
# =======

OPENSSL_OS="linux-aarch64"
export cfg_args="no-asm enable-static-engine"

source posix/$(basename $0)
