#!/bin/bash -e
# cURL
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

PKG_CONFIG_PATH="${OPENSSL_PATH}/lib/pkgconfig" \
LIBS="-ldl" \
./configure --prefix="${ins_dir}" --with-zlib="${ZLIB_PATH}" --with-ssl="${OPENSSL_PATH}" \
--without-ca-path --without-ca-bundle --without-libidn --disable-dict \
--disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http \
--enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps \
--disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps \
--disable-telnet --disable-tftp --disable-shared --enable-optimize \
--disable-debug --without-librtmp --enable-symbol-hiding ${cfg_args}

make_check_err -j 4
make_check_err install
