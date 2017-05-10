#!/bin/bash
# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./Configure --prefix="${ins_dir}" ${OPENSSL_OS} ${CFLAGS} ${cfg_args}

make -j 8
make install
cd ..
