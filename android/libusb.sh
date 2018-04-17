#!/bin/bash -e
# libusb
# ======

export cfg_flags="--host=${HOST}"
export CFLAGS="${CFLAGS} --include=sys/sysmacros.h"
source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.0.so ${ins_dir}/lib/libusb-$3.so

