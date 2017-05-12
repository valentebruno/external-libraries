#!/bin/bash -e
# Freetype-gl
# ===========

export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DGLEW_INCLUDE_PATH=\"${GLEW_PATH}/include\" -DGLEW_LIBRARY=\"${GLEW_PATH}/lib64/libGLEW.a\""

source posix/$(basename $0)
