#!/bin/bash -e
# Boost
# =====

boost_compiler_patch="s/using gcc ;/using gcc : arm : $(basename ${CXX}) ;/"
boost_additional_args=toolset="gcc-arm target-os=linux"
source posix/$(basename $0)
