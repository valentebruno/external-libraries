#!/bin/bash -e

src_dir=${BUILD_DIR}/$1
cd $src_dir/winbuild

nmake //f Makefile.vc mode=static VC=${VS_VER_NUM%\.0} MACHINE=${BUILD_ARCH} DEBUG=yes
nmake //f Makefile.vc mode=static VC=${VS_VER_NUM%\.0} MACHINE=${BUILD_ARCH} DEBUG=no

cd ..

mkdir -p $2/include/curl
mkdir -p $2/lib
cp include/curl/*.h $2/include/curl/

cp builds/libcurl-*-debug-*-winssl/lib/libcurl_a_debug.lib $2/lib/libcurld.lib
cp builds/libcurl-*-release-*-winssl/lib/libcurl_a.lib $2/lib/libcurl.lib
