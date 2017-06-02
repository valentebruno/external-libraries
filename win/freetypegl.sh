#!/bin/bash -e

CMAKE_ADDITIONAL_ARGS="-DFREETYPE_LIBRARY=${FREETYPE2_PATH}/lib/libfreetype.lib -DCMAKE_DEBUG_POSTFIX=d"

freetype_lib_dir="Debug"
source posix/$(basename $0)
