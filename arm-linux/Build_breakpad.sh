#!/bin/bash -e
# Breakpad [libc++]
# =================
src_dir=$1
ins_dir=$2
cd src/${src_dir}

export CXXFLAGS="${CXXFLAGS} -I /usr/include/arm-inux-gnueabihf"
BREAKPAD_FLAGS="--host=arm-linux"
source posix/$(basename $0)
