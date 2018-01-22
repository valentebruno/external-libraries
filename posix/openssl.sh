#!/bin/bash
# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

./Configure --prefix="${ins_dir}" ${OPENSSL_OS} ${CFLAGS} ${cfg_args}

make_check_err -j 8
make_check_err install
cd ..
