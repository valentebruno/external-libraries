#!/bin/bash
# libusb
# ======

source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.so.0.1.0 ${ins_dir}/lib/libusb-$3.so
