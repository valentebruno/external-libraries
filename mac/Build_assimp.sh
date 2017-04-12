# assimp
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir build
cd build
CXXFLAGS="-stdlib=libc++ -fvisibility=hidden" cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON -DCMAKE_INSTALL_PREFIX="${ins_dir}" -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10 -DCMAKE_OSX_SYSROOT=macosx10.12 -DASSIMP_BUILD_TESTS=OFF
make -j 9 && make install
cd ../..

