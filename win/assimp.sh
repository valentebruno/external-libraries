#!/bin/bash -e

export CMAKE_ADDITIONAL_ARGS="-DASSIMP_INSTALL_PDB:BOOL=OFF -DCMAKE_DEBUG_POSTFIX:STRING=d"
source posix/Build_$(basename $0)
