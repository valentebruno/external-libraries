#!/bin/bash
# libusb
# ======

source posix/$(basename $0)
install_name_tool -id @loader_path/libusb-$3.dylib libusb/.libs/libusb-$3.dylib
cp libusb/.libs/libusb-$3.dylib ${ins_dir}/lib/
