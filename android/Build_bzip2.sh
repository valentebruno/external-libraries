#!/bin/bash -e
# bzip2
# =====

export make_target=${libbz2.a bzip2 bzip2recover}
source posix/$(basename $0)
