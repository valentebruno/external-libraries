#!/bin/bash
basepath=$(dirname $(readlink -f $0) )

cd src

#Patch ICU
for pfile in ${basepath}/patch/*.patch
do
  patchbase=$(basename ${pfile} .patch)
  patch -i ${basepath}/patch/${patchbase}.patch -p0 -fsN -d ${patchbase}
done
