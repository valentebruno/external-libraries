#!/bin/bash -e

export OS_TARGET=WIN95
export BUILD_OPT=1
if [[ "${BUILD_ARCH}" == "x64" ]]; then
  export USE_64=1
fi
export MSYSTEM=MINGW32
export MOZILLABUILD="/c/mozilla-build"
export PATH="${MOZILLABUILD}/msys/bin:${MOZILLABUILD}/moztools${USE_64:+-x64}/bin:${PATH}"

source posix/$(basename $0)
