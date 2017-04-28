#!/bin/bash

export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries-x64"
export BUILD_ARCH=x64
export ARCH_FLAGS=-m64

source setup-library.sh

#required for bullet
setup-library http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz 3.0.0 -s "freeglut-3.0.0" -o "freeglut-3.0.0" -n "freeglut"

source setup-all-libraries.sh

SWIG_VERSION=3.0.3
setup-library http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz ${SWIG_VERSION} -s "swig-${SWIG_VERSION}" -o "swig-${SWIG_VERSION}" -n "swig"

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library git@github.com:leapmotion/libusb.git 1.0.0 -b leap-2.2.x
setup-library git@sf-github.leap.corp:leapmotion/libuvc.git 1.0.0 -b "master"
