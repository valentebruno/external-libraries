#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# bullet
# ======
BULLET_VERSION="2.84"
rm -fr bullet-${BULLET_VERSION}
git clone http://github.com/bulletphysics/bullet3.git bullet-${BULLET_VERSION}
cd bullet-${BULLET_VERSION}
git fetch
git checkout df3ddaca5eb
git clean -df

CXXFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden -fPIC" cmake -DCMAKE_BUILD_TYPE:STRING=Release -DGLUT_glut_LIBRARY:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/lib" -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm64.cmake -DGLUT_INCLUDE_DIR:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/include" -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}" -DBUILD_DEMOS:BOOL=OFF
make && make install
cd ..

