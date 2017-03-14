#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

# bullet
# ======

cd src

BULLET_VERSION="2.84"
git clone git@github.com:bulletphysics/bullet3.git bullet-${BULLET_VERSION}
cd bullet-${BULLET_VERSION}
git fetch
git checkout df3ddaca5eb
git clean -df
CC=clang CXXFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden" cmake -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.7" -DCMAKE_OSX_SYSROOT:PATH=macosx10.11 -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}" -DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF -DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF -DBUILD_UNIT_TESTS:BOOL=OFF
make -j 4 && make install # && (cd ${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}/include/; mv bullet/* .; rmdir bullet)
cd ..

cd ..
