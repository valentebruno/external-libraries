#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# cURL
# ====

ZLIB_VERSION="1.2.8"
CURL_VERSION="7.36.0"
curl -O "http://curl.askapache.com/download/curl-${CURL_VERSION}.tar.bz2"
rm -fr curl-${CURL_VERSION}
tar xfj "curl-${CURL_VERSION}.tar.bz2"
cd "curl-${CURL_VERSION}"
CC=${CROSS_COMPILER_PREFIX}gcc CXX=${CROSS_COMPILER_PREFIX}g++ PKG_CONFIG_PATH="${EXTERNAL_LIBRARY_DIR}/openssl/lib/pkgconfig" CFLAGS=-fPIC CXXFLAGS=-fPIC LDFLAGS="-ldl" ./configure --host=arm-linux --prefix="${EXTERNAL_LIBRARY_DIR}/curl-${CURL_VERSION}" --with-zlib="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/" --with-ssl --without-ca-path --without-ca-bundle --without-libidn --disable-dict --disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http --enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps --disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps --disable-telnet --disable-tftp --disable-shared --enable-optimize --disable-debug --enable-symbol-hiding || exit
make -j 4 && make install
cd ..

