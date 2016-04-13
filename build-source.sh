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

#Build OpenSSL
if [[ ! -d /c/dev/Libraries-x64_vc15/openssl ]]; then
  cmd  /c "script\\openssl.x64.cmd openssl C:\\dev\\Libraries-x64_vc15 openssl"
fi

#Build Curl

