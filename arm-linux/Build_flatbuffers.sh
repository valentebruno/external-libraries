#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

#typelimits error found in gcc5 with FB 1.0 - upgrading the library may resolve

PATH=${PATH}:. #only required in gcc5? what?
cmake ../ -DCMAKE_INSTALL_PREFIX=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} -DCMAKE_CXX_FLAGS="-Wno-type-limits" -DHAVE_X11_EXTENSIONS_XF86VMODE_H:BOOL=OFF -DX11_xf86vmode_FOUND:BOOL=OFF
make -j 9 && make install
