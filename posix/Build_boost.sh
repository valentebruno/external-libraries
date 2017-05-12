#!/bin/bash -e
# Boost 1.63
# ===================
src_dir=$1
ins_dir=$2

cd src/${src_dir}

rm -fr /tmp/$USER/boost
./bootstrap.sh ${boost_toolset}
mkdir -p ${ins_dir}

sed -i "${boost_compiler_patch}" project-config.jam
./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/ --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex link=static threading=multi variant=release ${boost_additional_args} install
