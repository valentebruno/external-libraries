#!/bin/bash
# Crossroads (libxs)
# ===========================

export cfg_args="--host=${HOST}"
export CXXFLAGS="${CXXFLAGS} -Wno-error=tautological-compare"
source posix/$(basename $0)
