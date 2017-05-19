#!/bin/bash
export BUILD_TYPE=mac

export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries"
export MACOSX_DEPLOYMENT_TARGET=10.10
export CMAKE_ADDITIONAL_ARGS="-DCMAKE_OSX_ARCHITECTURES:STRING=x86_64 -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10 -DCMAKE_OSX_SYSROOT=macosx10.12"
export CC=clang
export CXX=clang++
export CFLAGS="-mmacosx-version-min=10.10 -arch x86_64"
export CXXFLAGS="-stdlib=libc++"

source setup-all-libraries-posix.sh
