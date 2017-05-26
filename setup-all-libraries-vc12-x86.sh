#!/bin/bash
export EXT_LIB_INSTALL_ROOT='../Libraries-x86_vc12'
source log-output.sh

export BUILD_ARCH=x86
export MSVC_VER=2013

source ./setup-all-libraries-win.sh
