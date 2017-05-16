#!/bin/bash -e

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./autogen.sh
./configure --prefix="${ins_dir}" --enable-static --disable-shared ${cfg_args} \
CXXFLAGS="${CXXFLAGS} -D_THREAD_SAFE"
make && make install

# Superceded: presumably no longer needed in 3.0+
# The build system looks in the src directory for include files. Make a link for now.
#(cd "${ins_dir}"; ln -s include src)