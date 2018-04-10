#!/bin/bash -e
# Flatbuffers
# ====================================

#typelimits error found in gcc5 with FB 1.0 - upgrading the library may resolve
export CXXFLAGS="${CXXFLAGS} -Wno-type-limits"
export PATH=${PATH}:. #only required in gcc5? what?
export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DCMAKE_CXX_STANDARD:STRING=11"
source posix/$(basename $0)
