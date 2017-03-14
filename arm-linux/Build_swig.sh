#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"

# SWIG
# ====

SWIG_VERSION=3.0.3

if [ ! -f swig-${SWIG_VERSION}.tar.gz ]; then
  rm -f swig-${SWIG_VERSION}.tar.gz
  wget https://sourceforge.net/projects/swig/files/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz
fi

rm -fr swig-${SWIG_VERSION}
tar xfz "swig-${SWIG_VERSION}.tar.gz"
cd swig-${SWIG_VERSION}
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ ./configure --host=arm-linux --enable-shared=no --with-pcre --prefix="${EXTERNAL_LIBRARY_DIR}/swig-3.0.3" --with-boost="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}"
make -j 4 && make install
cd ..
