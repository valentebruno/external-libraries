# Freetype
# ========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
CC="clang" CFLAGS="-O3 -arch x86_64 -mmacosx-version-min=10.10 -fvisibility=hidden" ./configure --prefix="${ins_dir}" --without-zlib --without-bzip2 --without-png
make -j 9 && make install
cp docs/FTL.TXT "${ins_dir}"/
