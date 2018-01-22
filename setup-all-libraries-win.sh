#!/bin/bash

if [[ -z ${VisualStudioVersion} ]]; then
  echo "This script must be called from a shell that has run vcvarsall"
  exit -1
fi

#Pull in our config settings from the vcvars environment
export BUILD_TYPE=win
export BUILD_ARCH=${Platform,,}
export VS_VER_NUM=${VisualStudioVersion}
export VS_VER_SHORT=${VS_VER_NUM%\.0}
VC_VER=${VS_VER_SHORT}
if [[ "${VC_VER}" == "15" ]]; then
  VC_VER=141
fi
export VC_VER
export EXT_LIB_INSTALL_ROOT="../Libraries-${BUILD_ARCH}_vc${VC_VER}"
source log-output.sh

if [[ "${VisualStudioVersion}" == "15.0" ]]; then
  export VS_VER_YEAR=2017
elif [[ "${VisualStudioVersion}" == "14.0" ]]; then
  export VS_VER_YEAR=2015
elif [[ "${VisualStudioVersion}" == "12.0" ]]; then
  export VS_VER_YEAR=2013
else
  echo "Invalid VS_VER_YEAR=$VS_VER_YEAR"
  return
fi

if [[ ! -x $(which 7z 2> /dev/null) ]]; then
  export PATH=${PATH}:/c/Program\ Files/7-Zip
fi

if [[ ! -x $(which cmake 2> /dev/null) ]]; then
  export PATH=${PATH}:/c/Program\ Files/CMake/bin
fi

#Fix up path to find VS tools first
link_path=$(which -a link | grep Microsoft -m1)
link_dir=$(dirname "${link_path}")
export PATH="${link_dir}":"${PATH}"

export CMAKE_GENERATOR="Visual Studio ${VS_VER_SHORT} $VS_VER_YEAR"
if [[ "${BUILD_ARCH}" == "x64" ]]; then
  export CMAKE_GENERATOR="${CMAKE_GENERATOR} Win64"
fi

source ./setup-library.sh

setup-library https://chromium.googlesource.com/external/gyp 0.1 -g -b "master"

source ./setup-all-libraries.sh

setup-library git@github.com:dcnieho/FreeGLUT.git 3.0.0 -g -b FG_3_0_0
setup-library git@github.com:leapmotion/DShowBaseClasses.git 1.0.0 -g -o "baseclasses-1.0.0"
setup-library git@sf-github.leap.corp:leapmotion/CyAPI.git 1.3.2 -g
SWIG_VERSION=3.0.12
setup-library http://prdownloads.sourceforge.net/swig/swigwin-${SWIG_VERSION}.zip ${SWIG_VERSION} -s "swigwin-${SWIG_VERSION}" -o "swigwin-${SWIG_VERSION}" -n "swig"

PYTHON_VERSION=2.7.12
if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/python-${PYTHON_VERSION} ]]; then
  cd ${BUILD_DIR}
  if [[ $BUILD_ARCH == x64 ]]; then
    python_arch_suffix=.amd64
  fi
  curl -OL https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}${python_arch_suffix}.msi
  msiexec //a python-${PYTHON_VERSION}${python_arch_suffix}.msi TARGETDIR=$(cygpath -w ../${EXT_LIB_INSTALL_ROOT}/python-${PYTHON_VERSION}) //qb
  rm python-${PYTHON_VERSION}${python_arch_suffix}.msi
fi

