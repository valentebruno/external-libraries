# Freetype
# ========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

sed -e "/AUX.*.gxvalid/s@^# @@" \
    -e "/AUX.*.otvalid/s@^# @@" \
    -i modules.cfg

sed -r -e 's:.*(#.*SUBPIXEL.*) .*:\1:' \
    -i include/freetype/config/ftoption.h

./autogen.sh

./configure --prefix="${ins_dir}" --without-zlib --without-bzip2 --without-png \
CFLAGS="-O3 -fPIC -fvisibility=hidden"

make -j 9 && make install
cp docs/FTL.TXT "${ins_dir}"/
cd ..
