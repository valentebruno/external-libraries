#!/bin/bash
# Freetype-gl
# ===========

CMAKE_ADDITIONAL_ARGS="-DGLEW_INCLUDE_PATH:PATH=${GLEW_PATH}/include \
-DGLEW_LIBRARY:FILEPATH=${GLEW_PATH}/lib64/libGLEW.a"

source posix/$(basename $0)
