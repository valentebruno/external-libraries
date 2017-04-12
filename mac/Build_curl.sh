# cURL
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}


CC=clang CFLAGS="-arch x86_64" ./configure --prefix="${ins_dir}" --with-zlib="${ZILB_PATH}" --with-ssl="${OPENSSL_PATH}" --without-ca-path --without-ca-bundle --without-libidn --disable-dict --disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http --enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps --disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps --disable-telnet --disable-tftp --disable-shared --enable-optimize --disable-debug --enable-symbol-hiding
make -j 4
make install
