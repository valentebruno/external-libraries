#!/bin/bash -e
# LeapSerial
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

build_cmake_lib "${ins_dir}" -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}"
