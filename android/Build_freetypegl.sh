#!/bin/bash -e
# Freetype-gl
# ===========

src_dir=$1
ins_dir=$2
cd src/${src_dir}


cat <<EOF > opengl.h
/* Freetype GL - A C OpenGL Freetype engine
 *
 * Distributed under the OSI-approved BSD 2-Clause License.  See accompanying
 * file \`LICENSE\` for more details.
 */
#ifndef __OPEN_GL_H__
#define __OPEN_GL_H__

#if defined(__APPLE__)
#   include "TargetConditionals.h"
#   if TARGET_OS_SIMULATOR || TARGET_OS_IPHONE
#     if defined(FREETYPE_GL_ES_VERSION_3_0)
#       include <OpenGLES/ES3/gl.h>
#     else
#       include <OpenGLES/ES2/gl.h>
#     endif
#   else
#     include <OpenGL/gl.h>
#   endif
#elif defined(ANDROID)
#  if defined(FREETYPE_GL_ES_VERSION_3_0)
#    include <GLES3/gl3.h>
#  else
#    include <GLES2/gl2.h>
#  endif
#elif defined(_WIN32) || defined(_WIN64)
#  include <GL/glew.h>
#  include <GL/wglew.h>
#else
#  include <GL/glew.h>
#  include <GL/gl.h>
#endif

#endif /* OPEN_GL_H */
EOF

mkdir -p build
cd build

cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DFREETYPE_INCLUDE_DIRS="${FREETYPE2_PATH}/include/freetype2" \
-DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.a" \
-Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF \
-Dfreetype-gl_BUILD_MAKEFONT=OFF -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
-Dfreetype-gl_BUILD_TESTS=OFF \
-DOPENGL_gl_LIBRARY=GLESv2 -DOPENGL_INCLUDE_DIR:PATH=${NDK_TOOLCHAIN}/sysroot/usr/include

make -j 9
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp libfreetype-gl.a "${ins_dir}/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${ins_dir}/include/"
