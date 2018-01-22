#!/bin/bash
# AntTweakBar
# ====================

export make_args="CC=${CC} CXX=${CXX} LINK=${CC} ${make_args}"
source posix/$(basename $0)
