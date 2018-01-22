#!/bin/bash
# Freetype-gl
# ===========

cat <<EOF > ${BUILD_DIR}/$1/opengl.h
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

export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} \
-Dfreetype-gl_BUILD_TESTS=OFF -DOPENGL_gl_LIBRARY=GLESv2 \
-DOPENGL_INCLUDE_DIR:PATH=${NDK_TOOLCHAIN}/sysroot/usr/include"
source posix/$(basename $0)
