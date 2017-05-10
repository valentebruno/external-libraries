#!/bin/sh
# Boost 1.63 
# ===================

boost_compiler_patch=": arm : $(basename ${CXX}) ;"
boost_additional_args=toolset="gcc-arm target-os=linux"
source posix/$(basename $0)
