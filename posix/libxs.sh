#!/bin/bash
# Crossroads (libxs)
# ===========================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared ${cfg_args} \
CXXFLAGS="${CXXFLAGS} -O2 -D_THREAD_SAFE "
make_check_err && make_check_err install
cd ..
