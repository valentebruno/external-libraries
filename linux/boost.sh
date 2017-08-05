#!/bin/bash -e
# Boost 1.63
# ===================

boost_compiler_patch="s/using gcc ;/using gcc : : $(basename ${CXX}) ;/"

source ./posix/$(basename $0)
