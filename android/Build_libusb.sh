#!/bin/bash
# libusb
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./bootstrap.sh
echo ${HOST}
./configure --host=${HOST} --disable-udev --disable-log
make
mkdir -p ${ins_dir}/include/libusb
mkdir -p ${ins_dir}/lib
cp libusb/libusb.h ${ins_dir}/include/libusb/
cp libusb/.libs/libusb-1.0.so ${ins_dir}/lib/libusb-1.0.0.so
