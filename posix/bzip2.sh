#!/bin/bash -e
# bzip2
# =====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

set +e
patch -N  <<'MAKEFILE_OPTIONS'
*** Makefile    Fri May 19 04:03:43 2017
--- Makefile    Fri May 19 04:04:14 2017
***************
*** 14,27 ****

  SHELL=/bin/sh

- # To assist in cross-compiling
- CC=gcc
- AR=ar
- RANLIB=ranlib
- LDFLAGS=
-
  BIGFILES=-D_FILE_OFFSET_BITS=64
! CFLAGS=-Wall -Winline -O2 -g $(BIGFILES)

  # Where you want it installed when you do 'make install'
  PREFIX=/usr/local
--- 14,21 ----

  SHELL=/bin/sh

  BIGFILES=-D_FILE_OFFSET_BITS=64
! CFLAGS+=-Wall -Winline -O2 -g $(BIGFILES)

  # Where you want it installed when you do 'make install'
  PREFIX=/usr/local
MAKEFILE_OPTIONS
set -e
make -j 4 ${make_target} && make install PREFIX="${ins_dir}"

