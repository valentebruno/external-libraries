# SDL2
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CC="clang -arch x86_64" CFLAGS="-mmacosx-version-min=10.10" ./configure --prefix="${ins_dir}" --disable-shared --enable-static --disable-audio --disable-joystick --disable-haptic --host=x86_64-apple-darwin
make -j 4
make install
cd ..
