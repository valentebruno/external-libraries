#!/bin/bash -x
host_inst_dir=${HOST_LIB_ROOT}/$(basename ${2})

export cfg_args="--host=${HOST} --with-zlib \
--with-protoc=${host_inst_dir}/bin/protoc"
export CXXFLAGS="${CXXFLAGS} -I${ZLIB_PATH}/include"
export LDFLAGS="${LDFLAGS} -L${ZLIB_PATH}/lib"

source posix/$(basename $0)
