#!/bin/bash

source ./setup-library.sh

setup-library http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.zip 57.1 -s "icu" -o "icu-57.1" -n "icu"
setup-library https://chromium.googlesource.com/external/gyp 0.1 -g -b "master"

source ./setup-all-libraries.sh

setup-library https://github.com/dcnieho/FreeGLUT.git 3.0.0 -g -b FG_3_0_0
setup-library https://github.com/leapmotion/DShowBaseClasses.git 1.0.0 -g -o "baseclasses-1.0.0"

SWIG_VERSION=3.0.3
setup-library http://prdownloads.sourceforge.net/swig/swigwin-${SWIG_VERSION}.zip ${SWIG_VERSION} -s "swigwin-${SWIG_VERSION}" -o "swigwin-${SWIG_VERSION}" -n "swig"
