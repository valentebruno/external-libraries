#!/bin/bash -e
# LeapIPC
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}" -Dleapserial_DIR="${LEAPSERIAL_PATH}"
