#!/bin/bash
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x64"
source log-output.sh

export BUILD_TYPE=linux
export BUILD_ARCH=x64

export CXXFLAGS="-m64"
export CFLAGS="-m64"
export CXX="g++"
export CC="gcc"

source setup-all-libraries-posix.sh
