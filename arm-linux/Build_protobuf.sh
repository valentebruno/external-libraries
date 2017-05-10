#!/bin/sh

#required for gcc5?
export PATH=${PATH}:.
export CXXFLAGS="${CXXFLAGS} -I${ZLIB_PATH}/include"
export LDFLAGS="-L${ZLIB_PATH}/lib"
export cfg_args="--host=arm-linux --with-zlib"

source posix/$(basename $0)
