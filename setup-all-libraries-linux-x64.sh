#!/bin/bash
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x64"
source log-output.sh

export BUILD_TYPE=linux
export BUILD_ARCH=x64

export CXXFLAGS="-m64"
export CFLAGS="-m64"
export CXX="g++"
export CC="gcc"

source setup-library.sh
setup-library brew://python3 3.6.2 -o "python-3.6.2"
setup-library pip3://numpy 1.13.1

source setup-all-libraries-posix.sh

#For now, we depend on the jdk being located exactly here
if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/jdk ]]; then
  echo "Copying JDK..."
  cp -r /usr/lib/jvm/java-8-openjdk-amd64 ${EXT_LIB_INSTALL_ROOT}/jdk
fi

