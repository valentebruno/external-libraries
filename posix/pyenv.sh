#!/bin/bash

src_dir=$1
ins_dir=$2
version=$3

cd ${BUILD_DIR}/${src_dir}/plugins/python-build

# Install python builder
PREFIX=$ins_dir ./install.sh

# Install Python
PYTHON_CONFIGURE_OPTS="OPT='-fPIC'" $ins_dir/bin/python-build $version $ins_dir

# Install NumPy
$ins_dir/bin/pip3 install numpy==1.13.1
