#!/bin/bash
# Breakpad [libc++]
# =================

export CXXFLAGS="${CXXFLAGS} -I /usr/include/arm-inux-gnueabihf"
BREAKPAD_FLAGS="--host=arm-linux"
source posix/$(basename $0)
