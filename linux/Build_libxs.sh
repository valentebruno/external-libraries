# Crossroads (libxs) [libc++]
# ===========================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared \
CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE"
make && make install
cd ..