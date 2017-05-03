# Crossroads (libxs)
# ===========================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --host=${HOST} --prefix="${ins_dir}" --enable-static --disable-shared CXXFLAGS="-D_THREAD_SAFE -Wno-error=tautological-compare"
make && make install
