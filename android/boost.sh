#!/bin/bash
# Boost 1.63
# ===================

export boost_compiler_patch="s/using [^ ]* ;/using gcc : arm : $(basename ${CXX}) ;/"
export boost_additional_args="toolset=gcc-arm target-os=linux"
source posix/$(basename $0)
