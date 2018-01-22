#!/bin/bash

CMAKE_ADDITIONAL_ARGS="-DFREETYPE_LIBRARY=${FREETYPE2_PATH}/lib/libfreetype.lib -DCMAKE_DEBUG_POSTFIX=d"

source posix/$(basename $0)
