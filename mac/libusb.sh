#!/bin/bash
# libusb
# ======

source posix/$(basename $0)
install_name_tool -id @loader_path/libusb-1.0.0.dylib libusb/.libs/libusb-1.0.0.dylib
cp libusb/.libs/libusb-1.0.0.dylib ${ins_dir}/lib/
