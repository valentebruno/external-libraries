#!/bin/bash -e
# OpenCV
# ======n
CMAKE_ADDITIONAL_ARGS="-DENABLE_SSE41:BOOL=ON"

source posix/$(basename $0)
