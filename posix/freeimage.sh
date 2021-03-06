#!/bin/bash -e
# FreeImage
# =========

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

export DESTDIR=${ins_dir}
export INCDIR=${ins_dir}/include
export INSTALLDIR=${ins_dir}/lib
export INSTALLGROUP=$(id -g)

make_check_err -f Makefile.gnu -j 4 && make_check_err -f Makefile.gnu install
