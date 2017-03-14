#!/bin/bash -xe

# AntTweakBar
# ===========

EXTERNAL_LIBRARY_DIR=/home/jdonald
#curl -O http://www.antisphere.com/Tools/AntTweakBar/AntTweakBar_115.zip
rm -fr AntTweakBar
unzip -x AntTweakBar_115.zip
cd AntTweakBar/src
make
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
cp -R ../include/* "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include/"
cp ../lib/libAntTweakBar.so "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
(cd "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"; ln -s libAntTweakBar.so libAntTweakBar.so.1)
cd ../..


