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

#For now, we depend on the jdk being located exactly here
if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/jdk ]]; then
  echo "Copying JDK..."
  cp -r /usr/lib/jvm/java-8-openjdk-arm64 ${EXT_LIB_INSTALL_ROOT}/jdk
fi

