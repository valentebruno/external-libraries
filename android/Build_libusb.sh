#!/bin/bash
# libusb
# ======

source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.so ${ins_dir}/lib/libusb-1.0.0.so
