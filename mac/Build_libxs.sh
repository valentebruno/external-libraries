# Crossroads (libxs) [libc++]
# ===========================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared CXX=clang++ \
CXXFLAGS="-O2 -DLIBCXX_WORKAROUND=1 -D_THREAD_SAFE -mmacosx-version-min=10.9 \
-arch x86_64 -std=c++11 -stdlib=libc++"
make && make install
cd ..

