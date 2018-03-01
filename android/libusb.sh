#!/bin/bash
# libusb
# ======

export cfg_flags="--host=${HOST}"
source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.so ${ins_dir}/lib/libusb-$3.so
