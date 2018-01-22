#!/bin/bash
host_inst_dir=${HOST_LIB_ROOT}/$(basename ${2})

#required for gcc5?
export PATH=${PATH}:.
export cfg_args="--host=arm-linuxtic --with-zlib \
--with-protoc=${host_inst_dir}/bin/protoc"
export CXXFLAGS="${CXXFLAGS} -I${ZLIB_PATH}/include"
export LDFLAGS="${LDFLAGS} -L${ZLIB_PATH}/lib"
source posix/$(basename $0)
