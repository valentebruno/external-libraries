# Crossroads (libxs) [libc++]
# ===========================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --host=arm-linux --prefix="${ins_dir}" --enable-static --disable-shared \
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ \
CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE"
make && make install
