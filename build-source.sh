#!/bin/bash
export VSSETUP_COMMAND='"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64'

if [[ ! -d /c/dev/Libraries-x64_vc15/boost_1_60_0 ]]; then
  cmd /c "script\\boost_1_60_0.x64.cmd boost_1_60_0 C:\\dev\\Libraries-x64_vc15"
fi

