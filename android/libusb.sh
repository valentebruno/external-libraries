#!/bin/bash -e
# libusb
# ======

#src_dir=$1
#ins_dir=$2
#cd ${BUILD_DIR}/${src_dir}

export cfg_flags="--host=${HOST}"
export CFLAGS="${ARCH_FLAGS} -pie -O1 --include=sys/sysmacros.h "
export LDFLAGS="${LDFLAGS} -llog" 
# For as of yet unknown reasons, when compiling with clang
# the config descriptor sets bNumInterfaces to 1 when it should be 2.
# This will need to be figured out next time the NDK version gets
# bumped as GCC will be removed, but for now just use it to avoid
# the error.

source posix/$(basename $0)
cp libusb/.libs/libusb-1.0.0.so ${ins_dir}/lib/libusb-$3.so
