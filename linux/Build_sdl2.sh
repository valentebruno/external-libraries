# SDL2
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

chmod +x ./configure
CFLAGS="-fPIC" ./configure --prefix="${ins_dir}" --disable-shared --enable-static \
--disable-audio --disable-joystick --disable-haptic
make -j 4
make install
cd ..
