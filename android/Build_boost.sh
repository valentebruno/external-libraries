#!/bin/bash -xe

# Boost 1.63
# ===================
set -x
src_dir=$1
ins_dir=$2

cd src/${src_dir}

rm -fr /tmp/$USER/boost
./bootstrap.sh
mkdir -p ${ins_dir}
sed -i "s/using clang ;/using clang : arm : $(basename ${CXX}) ;/" project-config.jam
./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/ link=static threading=multi variant=release toolset=clang-arm target-os=linux --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex install
cd ..
