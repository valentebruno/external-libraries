#!/bin/bash -e
# Boost 1.63
# ===================

export boost_compiler_patch="s/using [^ ]* ;/using clang : arm : ${CXX//\//\\\/} ;/"
export boost_additional_args="toolset=clang-arm target-os=linux"
source posix/$(basename $0)
