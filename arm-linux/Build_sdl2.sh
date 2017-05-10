# SDL2
# ====

export cfg_args="--host=arm-linux"
./configure --prefix="${ins_dir}" --disable-shared --enable-static \
--disable-audio --disable-joystick --disable-haptic -host=arm-linux
make -j 4
make install
cd ..
