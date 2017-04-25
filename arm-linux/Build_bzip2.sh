# bzip2
# =====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

patch -p0 <<"MAKEFILE_OPTIONS"
--- Makefile  2016-07-07 12:59:14.181344400 -0700
+++ Makefile  2016-07-07 12:59:47.958115105 -0700
@@ -15,13 +15,13 @@
 SHELL=/bin/sh

 # To assist in cross-compiling
-CC=gcc
+CC=aarch64-linux-gnu-gcc
 AR=ar
 RANLIB=ranlib
 LDFLAGS=

 BIGFILES=-D_FILE_OFFSET_BITS=64
-CFLAGS=-Wall -Winline -O2 -g $(BIGFILES)
+CFLAGS=-Wall -Winline $(BIGFILES) -O3 -fvisibility=hidden -fPIC

 # Where you want it installed when you do 'make install'
 PREFIX=/usr/local
MAKEFILE_OPTIONS

make -j 4 && make install PREFIX="${ins_dir}"
