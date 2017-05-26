#!/bin/bash
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x86"
source log-output.sh

export BUILD_TYPE=linux
export BUILD_ARCH=x86

export CXXFLAGS="-m32"
export CFLAGS="-m32"
export CXX="g++"
export CC="gcc"

source setup-all-libraries-posix.sh
