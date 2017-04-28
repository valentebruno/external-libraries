#!/bin/bash
# libusb
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./bootstrap.sh
./configure --host=arm-linux --disable-udev CFLAGS="-O3 ${ARCH_FLAGS}"
make
mkdir -p ${ins_dir}/include/libusb
mkdir -p ${ins_dir}/lib
cp libusb/libusb.h ${ins_dir}/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${ins_dir}/lib/libusb-1.0.0.so
