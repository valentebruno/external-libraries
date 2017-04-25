# assimp
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

CXXFLAGS="-fvisibility=hidden -fPIC -O3 ${ARCH_FLAGS}" CFLAGS="-O3 ${ARCH_FLAGS} -fPIC" \
cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON \
-DCMAKE_INSTALL_PREFIX="${ins_dir}" -DCMAKE_BUILD_TYPE:STRING=Release \
-DASSIMP_BUILD_TESTS=OFF -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}

make -j 9 && make install
