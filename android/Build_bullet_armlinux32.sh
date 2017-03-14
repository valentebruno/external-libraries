#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm32

# freeglut
# ========

FREEGLUT_VERSION="2.8.0"

# bullet
# ======

BULLET_VERSION="2.84"
rm -fr bullet-${BULLET_VERSION}
git clone git@github.com:bulletphysics/bullet3.git bullet-${BULLET_VERSION}
cd bullet-${BULLET_VERSION}
git fetch
git checkout df3ddaca5eb
git clean -df

CXXFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden -fPIC" cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_TOOLCHAIN_FILE=~/platform/toolchain-arm.cmake -DGLUT_glut_LIBRARY:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/lib" -DGLUT_INCLUDE_DIR:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/include" -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}" -DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF -DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF -DBUILD_UNIT_TESTS:BOOL=OFF
make && make install
cd ..
