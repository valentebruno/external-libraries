#!/bin/bash

# LeapResource
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
-DAutowiring_DIR:PATH="${AUTOWIRING_PATH}" -DLeapSerial_DIR="${LEAPSERIAL_PATH}" \
-DBOOST_ROOT:PATH="${BOOST_PATH}"
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
