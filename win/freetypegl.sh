#!/bin/bash -e

#-DFREETYPE_INCLUDE_DIR_freetype2="%FREETYPE2_PATH%/include/freetype2" ^
#-DFREETYPE_INCLUDE_DIR_ft2build="%FREETYPE2_PATH%/include" ^
CMAKE_ADDITIONAL_ARGS="-DFREETYPE_LIBRARY=${FREETYPE2_PATH}/lib/libfreetype.lib"

source posix/Build_$(basename $0)
