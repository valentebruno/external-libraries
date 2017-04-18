# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}


mkdir build
cd build
CFLAGS="-fvisibility=hidden -fPIC -O3 ${ARCH_FLAGS}" \
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DFREETYPE_INCLUDE_DIRS="${FREETYPE2_PATH}/include/freetype2" \
-DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.a" \
-Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF \
-Dfreetype-gl_BUILD_MAKEFONT=OFF \
-DGLEW_INCLUDE_PATH="${GLEW_PATH}/include" \
-DGLEW_LIBRARY="${GLEW_PATH}/lib64/libGLEW.a"

make -j 9
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp libfreetype-gl.a "${ins_dir}/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${ins_dir}/include/"
cd ..
