#!/bin/bash
git apply --directory="$(realpath --relative-to=. src/$1)" android/flatbuffers.patch
source posix/$(basename $0)
