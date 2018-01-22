#!/bin/bash

if [[ "${BUILD_ARCH}" == "x64" ]]; then
  boost_additional_args="address-model=64 architecture=ia64"
else
  boost_additional_args="architecture=x86"
fi
src_dir=$1

if [[ ! -x ${BUILD_DIR}/$src_dir/b2.exe ]]; then
  cd ${BUILD_DIR/$src_dir && cmd //C "bootstrap.bat" && cd ../..
fi

if [[ ${VS_VER_NUM} == 15.0 ]]; then
  VS_VER_NUM=14.1

  #workaround for boost 1.63 & VS2017. Remove in 1.64
  cat > BUILD_DIR/$src_dir/project-config.jam<<CONFIGFILE
import option ;

using msvc : ${VS_VER_NUM} : "$(cygpath -w "$(which cl)")" ;

option.set keep-going : false ;
CONFIGFILE
else
  boost_compiler_patch="s/using msvc ;/using msvc : ${VS_VER_NUM} ;/"
fi

boost_additional_args="${boost_additional_args} variant=debug runtime-link=shared toolset=msvc-${VS_VER_NUM} -j4 --ignore-config"
source posix/$(basename $0)
