# SDL2
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

chmod +x ./configure
./configure --prefix="${ins_dir}" --disable-shared --enable-static \
--disable-audio --disable-joystick --disable-haptic --host=${HOST}
make -j 4
make install
