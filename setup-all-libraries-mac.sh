#!/bin/bash

export EXT_LIB_INSTALL_ROOT="$(cd ..; pwd)/Libraries"
export MACOSX_DEPLOYMENT_TARGET=10.10

source setup-all-libraries.sh
setup-library git://code.qt.io/qt/qt5.git 5.8.0 -o "qt-5.8.0"

SWIG_VERSION=3.0.3
setup-library http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz ${SWIG_VERSION} -s "swig-${SWIG_VERSION}" -o "swig-${SWIG_VERSION}" -n "swig"

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library https://github.com/leapmotion/libusb.git 1.0.0 -g -b leap-2.2.x
setup-library https://sf-github.leap.corp/leapmotion/libuvc.git 1.0.0 -g -b "master"

