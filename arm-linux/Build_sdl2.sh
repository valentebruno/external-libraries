# SDL2
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

chmod +x ./configure
CC=aarch64-linux-gnu-gcc CFLAGS="-fPIC" ./configure --prefix="${ins_dir}" --disable-shared --enable-static \
--disable-audio --disable-joystick --disable-haptic -host=arm-linux
make -j 4
make install
cd ..
