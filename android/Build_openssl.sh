# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

OPENSSL_OS="linux-aarch64"
./Configure -fPIC --prefix="${ins_dir}" ${OPENSSL_OS} no-asm enable-static-engine

make -k -j 8 || true
make -k install || true
