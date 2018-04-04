#!/bin/bash -e
# OpenSSL
# =======

export OPENSSL_OS=darwin64-x86_64-cc
export CFLAGS=${CFLAGS//-arch x86_64/} #set by openssl_os
export cfg_args="-mmacosx-version-min=10.10"
source posix/$(basename $0)
