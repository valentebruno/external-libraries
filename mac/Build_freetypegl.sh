# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir build
cd build
CFLAGS="-mmacosx-version-min=10.10 -fvisibility=hidden" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10 -DCMAKE_OSX_SYSROOT=macosx10.12 \
-DFREETYPE_INCLUDE_DIR_freetype2="${FREETYPE2_PATH}/include/freetype2" \
-DFREETYPE_INCLUDE_DIR_ft2build="${FREETYPE2_PATH}/include" -DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.a" \
-Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF -Dfreetype-gl_BUILD_MAKEFONT=OFF -Dfreetype-gl_BUILD_TESTS=OFF
make -j 9
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp libfreetype-gl.a "${ins_dir}/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${ins_dir}/include/"
cd ..
