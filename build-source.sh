#!/bin/bash
export VSSETUP_COMMAND='"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64'

#Build Boost
if [[ ! -d /c/dev/Libraries-x64_vc15/boost_1_60_0 ]]; then
  cmd /c "script\\boost_1_60_0.x64.cmd boost_1_60_0 C:\\dev\\Libraries-x64_vc15 boost_1_60_0"
fi

#Build zlib
if [[ ! -d /c/dev/Libraries-x64_vc15/zlib-1.2.8 ]]; then
  cmd /c "script\\zlib.x64.cmd zlib C:\\dev\\Libraries-x64_vc15 zlib-1.2.8"
fi
export ZLIB_PATH=C:\\dev\\Libraries-x64_vc15\\zlib-1.2.8

#Build OpenSSL
if [[ ! -d /c/dev/Libraries-x64_vc15/openssl-1.0.2g ]]; then
  cmd /c "script\\openssl.x64.cmd openssl C:\\dev\\Libraries-x64_vc15 openssl-1.0.2g"
fi
export OPENSSL_PATH=C:\\dev\\Libraries-x64_vc15\\openssl-1.0.2g

#Build Curl
if [[ ! -d /c/dev/Libraries-x64_vc15/curl-7.48.0 ]]; then
  cmd /c "script\\curl.x64.cmd curl c:\\dev\\Libraries-x64_vc15 curl-7.48.0"
fi
export CURL_PATH=C:\\dev\\Libraries-x64_vc15\\curl-7.48.0

#Build ICU
if [[ ! -d /c/dev/Libraries-x64_vc15/icu-57.1 ]]; then
  cmd /c "script\\icu.x64.cmd icu c:\\dev\\Libraries-x64_vc15 icu-57.1"
fi
export ICU_PATH=C:\\dev\\Libraries-x64_vc15\\icu-57.1

#Build Qt
if [[ ! -d /c/dev/Libraries-x64_vc15/qt-5.6.0 ]]; then
  cmd /c "script\\qt5.x64.cmd qt5 c:\\dev\\Libraries-x64_vc15 qt-5.6.0"
fi
