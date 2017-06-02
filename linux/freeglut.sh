#!/bin/bash -e
# freeglut
# ======

sed 's/IF(X11_xf86vmode_FOUND)/IF(FALSE)/g' -i src/$1/CMakeLists.txt
sed 's/IF(X11_Xrandr_FOUND)/IF(FALSE)/g' -i src/$1/CMakeLists.txt

source posix/$(basename $0)
