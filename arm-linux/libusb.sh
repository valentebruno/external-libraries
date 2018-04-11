#!/bin/bash -e
# libusb
# ======

export cfg_flags="--host=arm-linux"
source posix/$(basename $0)

cp libusb/.libs/libusb-1.0.so.0.1.0 ${ins_dir}/lib/libusb-$3.so
