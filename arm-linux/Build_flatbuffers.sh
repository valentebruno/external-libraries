#!/bin/sh
# Flatbuffers
# ====================================

#typelimits error found in gcc5 with FB 1.0 - upgrading the library may resolve
export CXXFLAGS="${CXXFLAGS} -Wno-type-limits"
export PATH=${PATH}:. #only required in gcc5? what?
export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DHAVE_X11_EXTENSIONS_XF86VMODE_H:BOOL=OFF -DX11_xf86vmode_FOUND:BOOL=OFF"
source posix/$(basename $0)
