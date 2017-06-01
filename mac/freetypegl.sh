#!/bin/bash -e
# Freetype-gl
# ===========

export CMAKE_ADDITIONAL_ARGS="-Dfreetype-gl_BUILD_TESTS=OFF"
source posix/$(basename $0)
