# SWIG
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ \
./configure --host=arm-linux --enable-shared=no --with-pcre \
--prefix="${ins_dir}" --with-boost="${BOOST_PATH}"
make -j 4 && make install
cd ..
