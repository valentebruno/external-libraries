#!/bin/sh

src_dir=$1
ins_dir=$2
cd src/${src_dir}

host_inst_dir=${HOST_LIB_ROOT}/$(basename ${ins_dir})

./autogen.sh
./configure --host=arm-linux --prefix="${ins_dir}" --enable-static --disable-shared \
--with-zlib --with-protoc=${host_inst_dir}/bin/protoc \
CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden -I${ZLIB_PATH}/include" \
LDFLAGS="-L${ZLIB_PATH}/lib"
make && make install
