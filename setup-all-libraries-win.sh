#!/bin/bash

if [[! -x 7z ]]; then
  export PATH=${PATH}:/c/Program\ Files/7-Zip
fi

if [[ $BUILD_ARCH == "x64" ]]; then
  VS_ARCH_ARG=amd64
else
  VS_ARCH_ARG=x86
fi

if [[ $MSVC_VER == 2013 ]]; then
  VS_VER_NUM=12.0
elif [[ $MSVC_VER == 2015 ]]; then
  VS_VER_NUM=14.0
elif [[ $MSVC_VER == 2017 ]]; then
  VS_VER_NUM=15.0
else
  echo "Invalid MSVC_VER=$MSVC_VER"
  return
fi

export VSSETUP_COMMAND="\"C:\\Program Files (x86)\\Microsoft Visual Studio $VS_VER_NUM\\VC\\vcvarsall.bat\" $VS_ARCH_ARG"
export CMAKE_COMMAND='"C:\Program Files\CMake\bin\cmake.exe"'
export CMAKE_GENERATOR="Visual Studio ${VS_VER_NUM%\.0} $MSVC_VER"

source ./setup-library.sh

setup-library https://chromium.googlesource.com/external/gyp 0.1 -g -b "master"

source ./setup-all-libraries.sh
setup-library git://code.qt.io/qt/qt5.git 5.8.0 -o "qt-5.8.0"

setup-library https://github.com/dcnieho/FreeGLUT.git 3.0.0 -g -b FG_3_0_0
setup-library https://github.com/leapmotion/DShowBaseClasses.git 1.0.0 -g -o "baseclasses-1.0.0"

SWIG_VERSION=3.0.3
setup-library http://prdownloads.sourceforge.net/swig/swigwin-${SWIG_VERSION}.zip ${SWIG_VERSION} -s "swigwin-${SWIG_VERSION}" -o "swigwin-${SWIG_VERSION}" -n "swig"
