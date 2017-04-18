# bzip2
# =====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

patch -p0 <<"MAKEFILE_OPTIONS"
--- Makefile    2016-07-07 11:53:54.000000000 -0700
+++ Makefile    2016-07-07 11:54:34.000000000 -0700
@@ -21,7 +21,7 @@
 LDFLAGS=

 BIGFILES=-D_FILE_OFFSET_BITS=64
-CFLAGS=-Wall -Winline -O2 -g $(BIGFILES)
+CFLAGS=-Wall -Winline $(BIGFILES) -fvisibility=hidden -fvisibility-inlines-hidden -fPIC

 # Where you want it installed when you do 'make install'
 PREFIX=/usr/local
MAKEFILE_OPTIONS
make -j 4 && make install PREFIX="${ins_dir}"
cd ..
