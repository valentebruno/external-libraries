#!/bin/bash
export EXT_LIB_INSTALL_ROOT=../Libraries-x64_vc12
source log-output.sh

export BUILD_ARCH=x64
export MSVC_VER=2013

source ./setup-all-libraries-win.sh
