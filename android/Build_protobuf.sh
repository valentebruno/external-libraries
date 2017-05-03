#!/bin/sh

src_dir=$1
ins_dir=$2
cd src/${src_dir}

host_inst_dir=${HOST_LIB_ROOT}/$(basename ${ins_dir})

#required for gcc5?
PATH=${PATH}:.

./autogen.sh

./configure --host=arm-linux --prefix="${ins_dir}" --enable-static --disable-shared \
--with-zlib --with-protoc=${host_inst_dir}/bin/protoc \
CXXFLAGS="-D_THREAD_SAFE -I${ZLIB_PATH}/include" LDFLAGS="-L${ZLIB_PATH}/lib"
make -j8 && make install
