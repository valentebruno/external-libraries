#!/bin/bash -e

CMAKE_ADDITIONAL_ARGS="-DFREETYPE_LIBRARY=${FREETYPE2_PATH}/lib/libfreetype.lib"

freetype_lib_dir="Debug"
source posix/$(basename $0)
