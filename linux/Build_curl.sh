# cURL
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

PKG_CONFIG_PATH="${OPENSSL_PATH}/lib/pkgconfig" LDFLAGS="-ldl" \
./configure --prefix="${ins_dir}" --with-zlib="${ZLIB_PATH}/" --with-ssl \
--without-ca-path --without-ca-bundle --without-libidn --disable-dict \
--disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http \
--enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps \
--disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps \
--disable-telnet --disable-tftp --disable-shared --enable-optimize \
--disable-debug --without-librtmp --enable-symbol-hiding

make -j 4
make install
