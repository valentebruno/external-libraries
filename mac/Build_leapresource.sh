#!/bin/bash

# LeapResource
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.10" \
-DAutowiring_DIR:PATH="${AUTOWIRING_PATH}" -DLeapSerial_DIR="${LEAPSERIAL_PATH}" \
-DBOOST_ROOT:PATH="${BOOST_PATH}" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386"
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
