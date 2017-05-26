#!/bin/bash
export EXT_LIB_INSTALL_ROOT='../Libraries-x64_vc14'
source log-output.sh

export BUILD_ARCH=x64
export MSVC_VER=2015

source ./setup-all-libraries-win.sh
