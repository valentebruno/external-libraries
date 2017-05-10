#!/bin/sh

export cfg_args="--with-zlib"
export CPPFLAGS="${CPPFLAGS} -I${ZLIB_PATH}/include"
export LDFLAGS="-L${ZLIB_PATH}/lib -lz"

source posix/$(basename $0)
