# assimp
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

CXXFLAGS="-fvisibility=hidden -fPIC -O3 ${ARCH_FLAGS}" CFLAGS="-O3 ${ARCH_FLAGS}" \
LDFLAGS="-L/usr/lib32 -L/usr/lib/i386-linux-gnu" \
cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON \
-DCMAKE_INSTALL_PREFIX="${ins_dir}" -DCMAKE_BUILD_TYPE:STRING=Release \
-DASSIMP_BUILD_TESTS=OFF

make -j 9 && make install
