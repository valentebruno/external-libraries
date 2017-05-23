#!/bin/bash -e
# Boost 1.63
# ===================
src_dir=$1
ins_dir=$2

cd src/${src_dir}

rm -fr /tmp/$USER/boost
./bootstrap.sh ${boost_toolset}
mkdir -p ${ins_dir}

if [[ -n ${boost_compiler_patch} ]]; then
  sed -i "${boost_compiler_patch}" project-config.jam
fi
set -x
./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/ --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex link=static threading=multi variant=release cflags="${CFLAGS}" cxxflags="${CXXFLAGS}" ${boost_additional_args} -d2 --debug-building install
