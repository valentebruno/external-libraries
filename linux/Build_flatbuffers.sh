#!/bin/bash -e
# Flatbuffers
# =======

CMAKE_ADDITIONAL_ARGS="-DHAVE_X11_EXTENSIONS_XF86VMODE_H:BOOL=OFF -DX11_xf86vmode_FOUND:BOOL=OFF"

source posix/$(basename $0)
