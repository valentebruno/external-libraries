#!/bin/bash -e
# SWIG
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

PCRE_VERSION=8.38
if [ ! -f pcre-${PCRE_VERSION}.tar.bz2 ]; then
  curl -O "http://iweb.dl.sourceforge.net/project/pcre/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.bz2"
fi

tar xfj "pcre-${PCRE_VERSION}.tar.bz2"
cd pcre-${PCRE_VERSION}
./configure --enable-shared=no --prefix="`pwd`/../pcre"
make -j 4 && make install
cd ..
./configure --with-pcre --with-pcre-prefix="`pwd`/pcre" --prefix="${ins_dir}" --with-boost="${BOOST_PATH}"
make -j 4 && make install

