# SWIG
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./configure --host=${HOST} --enable-shared=no --with-pcre \
--prefix="${ins_dir}" --with-boost="${BOOST_PATH}"
make -j 4 && make install
cd ..
