# freeglut
# ======

src_dir=$1
ins_dir=$2
echo $src
cd src/${src_dir}

CPPFLAGS="-fPIC"
cmake . -DCMAKE_INSTALL_PREFIX=${ins_dir} -DFREEGLUT_BUILD_DEMOS:BOOL=OFF \
-DFREEGLUT_BUILD_SHARED_LIBS:BOOL=OFF -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=ON

make -j 9 && make install
