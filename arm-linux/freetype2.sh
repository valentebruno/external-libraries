#!/bin/bash
# Freetype
# ========

export LDFLAGS="-L/usr/lib/${HOST}"
export cfg_args="--host=${HOST}"

source posix/$(basename $0)
