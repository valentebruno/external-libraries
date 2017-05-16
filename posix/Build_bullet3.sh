#!/bin/bash -e
# bullet
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake -DCMAKE_BUILD_TYPE:STRING=Release \
-DGLUT_glut_LIBRARY:PATH="${FREEGLUT_PATH}/lib" \
-DGLUT_INCLUDE_DIR:PATH="${FREEGLUT_PATH}/include" \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" \
-DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF \
-DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF \
-DBUILD_UNIT_TESTS:BOOL=OFF ${CMAKE_ADDITIONAL_ARGS}

make -j 4 && make install