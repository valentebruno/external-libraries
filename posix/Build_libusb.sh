#!/bin/bash -e
# libusb
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./bootstrap.sh
./configure --disable-udev ${cfg_flags}
make
mkdir -p ${ins_dir}/include/libusb
mkdir -p ${ins_dir}/lib
cp libusb/libusb.h ${ins_dir}/include/libusb/

