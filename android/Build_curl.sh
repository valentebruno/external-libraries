#!/bin/bash
# cURL
# ====

export LIBS="-ldl"
export cfg_args="--host=${HOST}"
source posix/$(basename $0)
