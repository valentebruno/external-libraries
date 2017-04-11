#!/bin/sh

# Boost 1.63 [libc++]
# ===================

src_dir=$1
ins_dir=$2

cd src/${src_dir}

rm -fr /tmp/boost
./bootstrap.sh --with-toolset=clang
./b2 --prefix="${ins_dir}" --build-dir=/tmp --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex link=static threading=multi variant=release cxxflags="-mmacosx-version-min=10.7 -arch x86_64 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden -stdlib=libc++" install

cd ..
