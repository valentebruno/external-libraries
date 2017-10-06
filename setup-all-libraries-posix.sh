#!/bin/bash
# For a build environment, see linux-build-env/Dockerfile.xenial-android64

if [[ -z BUILD_TYPE ]]; then
  echo "BUILD_TYPE must be defined"
fi

export CFLAGS="${CFLAGS} -O3 -fPIC"
export CXXFLAGS="${CXXFLAGS} -O3 -fPIC -fvisibility=hidden -fvisibility-inlines-hidden"
export CMAKE_BUILD_ARGS="-j4"
source setup-library.sh

#required for bullet
setup-library http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz 3.0.0 -s "freeglut-3.0.0" -o "freeglut-3.0.0" -n "freeglut"

source setup-all-libraries.sh

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library https://github.com/leapmotion/libusb.git 1.0.0 -g -b leap-2.2.x
setup-library http://sf-github.leap.corp/leapmotion/libuvc.git 1.0.1 -g -b "master"

SWIG_VERSION=3.0.12
setup-library http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz ${SWIG_VERSION} -s "swig-${SWIG_VERSION}" -o "swig-${SWIG_VERSION}" -n "swig"
