#!/bin/bash
export BUILD_TYPE=linux

export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x86"
export BUILD_ARCH=x86

export CXXFLAGS="-m32"
export CFLAGS="-m32"
export CXX="g++"
export CC="gcc"

source setup-all-libraries-posix.sh
