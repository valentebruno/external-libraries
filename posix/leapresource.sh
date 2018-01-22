#!/bin/bash
# LeapResource
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -DAutowiring_DIR:PATH="${AUTOWIRING_PATH}" -DLeapSerial_DIR="${LEAPSERIAL_PATH}" \
-DBOOST_ROOT:PATH="${BOOST_PATH}"
