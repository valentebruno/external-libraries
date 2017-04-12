#!/bin/bash

export EXT_LIB_INSTALL_ROOT='/Users/wgray/Libraries'
export MACOSX_DEPLOYMENT_TARGET=10.10

source setup-all-libraries.sh

BZIP2_VERSION="1.0.6"
setup-library http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz ${BZIP2_VERSION} -n "bzip2" -s "bzip2-${BZIP2_VERSION}" -o "bzip2-${BZIP2_VERSION}"

setup-library git@github.com:leapmotion/libusb.git 1.0.0 -b leap-2.2.x
setup-library git@sf-github.leap.corp:leapmotion/libuvc.git 1.0.0 -b "master"

