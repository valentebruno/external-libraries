#!/bin/bash -e
# libusb
# ======

source posix/$(basename $0)
install_name_tool -id @loader_path/libusb-$3.dylib libusb/.libs/libusb-1.0.0.dylib
cp libusb/.libs/libusb-1.0.0.dylib ${ins_dir}/lib/libusb-$3.dylib
