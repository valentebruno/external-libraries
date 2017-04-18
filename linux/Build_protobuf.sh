#!/bin/sh

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared \
CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden"
make && make install

# Superceded: presumably no longer needed in 3.0+
# The build system looks in the src directory for include files. Make a link for now.
#(cd "${ins_dir}"; ln -s include src)

