#!bin/sh
cd $1/../src

cd $2
export HOME=$(pwd)

cd nss

export OS_TARGET=WIN95

if [[ "${BUILD_ARCH}" == "x64" ]]; then
  export USE_64=1
fi

export BUILD_OPT="1"
export MSYSTEM=MINGW32

make nss_build_all
