#!/bin/bash
export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_ARCH=x64
export ARCH_FLAGS=-m64

export CC=gcc
export CXX=g++
export AR=gcc-ar
export LD=ld

source setup-library.sh
setup-library git@github.com:google/flatbuffers.git 1.0.3 -b "@e97f38e" #Not actually 1.0.3
setup-library git@github.com:google/protobuf.git 3.0.2

setup-library http://downloads.sourceforge.net/project/boost/boost/1.63.0/boost_1_63_0.tar.gz 1.63.0 -s "boost_1_63_0" -o "boost_1_63_0" -n "boost"
setup-library git@github.com:leapmotion/autowiring.git 1.0.3 -o autowiring-1.0.3
setup-library git@github.com:leapmotion/leapserial.git 0.4.0 -o LeapSerial-0.4.0
setup-library git@github.com:leapmotion/leapresource.git 0.1.0 -o LeapResource-0.1.0

SWIG_VERSION=3.0.3
setup-library http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz ${SWIG_VERSION} -s "swig-${SWIG_VERSION}" -o "swig-${SWIG_VERSION}" -n "swig"
