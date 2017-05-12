#!/bin/bash -e
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

cd ../..
source posix/$(basename $0)
