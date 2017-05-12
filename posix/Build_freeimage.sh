#!/bin/bash -e
# FreeImage
# =========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

export DESTDIR=${ins_dir}
export INCDIR=${ins_dir}/include
export INSTALLDIR=${ins_dir}/lib
export INSTALLGROUP=$(id -g)

for file in $(find . -name "Makefile*"); do
  sed 's/-o root -g root/-g $(INSTALLGROUP)/g' -i ${file}
done

make -f Makefile.gnu -j 4 && make -f Makefile.gnu install
