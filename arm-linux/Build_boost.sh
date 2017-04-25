#!/bin/sh

# Boost 1.63 [libc++]
# ===================
set -x
src_dir=$1
ins_dir=$2

cd src/${src_dir}

rm -fr /tmp/$USER/boost
./bootstrap.sh
mkdir -p ${ins_dir}
sed -i "s/using gcc ;/using gcc : arm : $(basename ${CXX}) ;/" project-config.jam
./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/ link=static threading=multi variant=release cflags="-fPIC" cxxflags="-fPIC" toolset=gcc-arm target-os=linux  ${ADDITIONAL_ARGS} --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex install

cd ..
