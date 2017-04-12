# OpenSSL
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./Configure --prefix="${ins_dir}" darwin64-x86_64-cc -mmacosx-version-min=10.10
make -j 8
make install
cd ..
