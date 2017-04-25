#!/bin/sh
# Flatbuffers
# ====================================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

CXXFLAGS="-fPIC" cmake . -DCMAKE_INSTALL_PREFIX=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} -DHAVE_X11_EXTENSIONS_XF86VMODE_H:BOOL=OFF -DX11_xf86vmode_FOUND:BOOL=OFF
make -j 9 && make install
