#!/bin/bash

if [[ $VS_VER_YEAR == 2017 ]]; then
  export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DBoost_COMPILER:STRING=-vc141"
fi

source posix/$(basename $0)
