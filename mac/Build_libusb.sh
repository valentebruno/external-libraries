#!/bin/bash
# libusb
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./bootstrap.sh
./configure --disable-log CC=clang CFLAGS="-O3 -mmacosx-version-min=10.10 -arch x86_64"
make
install_name_tool -id @loader_path/libusb-1.0.0.dylib libusb/.libs/libusb-1.0.0.dylib
mkdir -p ${ins_dir}/include/libusb
mkdir -p ${ins_dir}/lib
cp libusb/libusb.h ${ins_dir}/include/libusb/
cp libusb/.libs/libusb-1.0.0.dylib ${ins_dir}/lib/
