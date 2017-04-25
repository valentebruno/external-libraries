# Freetype
# ========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

HOST="aarch64-linux-gnu"

./autogen.sh

LDFLAGS="-L/usr/lib/${HOST}" \
CFLAGS="-O3 -fPIC -fvisibility=hidden" ./configure --prefix="${ins_dir}" \
--without-zlib --without-bzip2 --without-png --host=${HOST}
make -j 9 && make install
cp docs/FTL.TXT "${ins_dir}"/
