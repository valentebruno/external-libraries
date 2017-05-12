#!/bin/bash -e
# assimp
# ======

export LDFLAGS="-L/usr/lib32 -L/usr/lib/i386-linux-gnu"

source posix/$(basename $0)
