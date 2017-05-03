# freeglut
# ======

src_dir=$1
ins_dir=$2
echo $src
cd src/${src_dir}

sed 's/IF(X11_xf86vmode_FOUND)/IF(FALSE)/g' -i CMakeLists.txt
sed 's/IF(X11_Xrandr_FOUND)/IF(FALSE)/g' -i CMakeLists.txt
sed '/-mandroid/d' -i CMakeLists.txt
sed '/-gstabs+/d' -i CMakeLists.txt

# For Freeglut 3.0.0
mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
-DFREEGLUT_GLES:BOOL=ON -DFREEGLUT_BUILD_DEMOS:BOOL=OFF -DFREEGLUT_BUILD_SHARED_LIBS:BOOL=OFF -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=ON

make -j 9 && make install
