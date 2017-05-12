#!/bin/bash -e
# libusb
# ======

source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.0.dylib ${ins_dir}/lib/
