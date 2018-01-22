#!/bin/bash
# SDL2
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

chmod +x ./configure
./configure --prefix="${ins_dir}" --disable-shared --enable-static \
--disable-audio --disable-joystick --disable-haptic ${cfg_args}
make_check_err -j 4
make_check_err install
