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
./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/ --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex link=static threading=multi variant=release cflags=-fPIC cxxflags=-fPIC install

cd ..
