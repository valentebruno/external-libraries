# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

if [ "${BUILD_ARCH}" == "x64" ]; then
  OPENSSL_OS="linux-x86_64"
else
  OPENSSL_OS="linux-generic32"
fi

./Configure -fPIC --prefix="${ins_dir}" ${OPENSSL_OS} no-asm enable-static-engine

make -j 8
make install
cd ..
