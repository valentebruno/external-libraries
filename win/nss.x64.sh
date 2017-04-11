#!bin/sh
cd $1/../src

cd $2
export HOME=$(pwd)

cd nss

export OS_TARGET=WIN95
export USE_64=1
export BUILD_OPT="1"
export MSYSTEM=MINGW32

make nss_build_all
