# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

export OPENSSL_OS=darwin64-x86_64-cc
export cfg_args="-mmacosx-version-min=10.10"
./Configure --prefix="${ins_dir}"
make -j 8
make install
