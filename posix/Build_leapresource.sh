#!/bin/bash -e
# LeapResource
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} \
-DAutowiring_DIR:PATH="${AUTOWIRING_PATH}" -DLeapSerial_DIR="${LEAPSERIAL_PATH}" \
-DBOOST_ROOT:PATH="${BOOST_PATH}" ${CMAKE_ADDITIONAL_ARGS}
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
