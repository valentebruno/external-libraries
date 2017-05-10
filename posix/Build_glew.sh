#!/bin/bash
# glew
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

GLEW_DEST="${ins_dir}" make install
