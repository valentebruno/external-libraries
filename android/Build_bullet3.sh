# bullet
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

export CXXFLAGS="-fno-exceptions -ffast-math"
cmake ../ -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
-DGLUT_glut_LIBRARY:PATH="${FREEGLUT_PATH}/lib" \
-DGLUT_INCLUDE_DIR:PATH="${FREEGLUT_PATH}/include" \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" \
-DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF \
-DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF \
-DBUILD_UNIT_TESTS:BOOL=OFF

make -j 4 && make install
