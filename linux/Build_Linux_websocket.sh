#!/bin/bash -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

MACHINE=`uname -m`
if [ "${MACHINE}" == "x86_64" ]; then
  ARCH_FLAGS="-m64"
else
  ARCH_FLAGS="-m32"
fi

rm -fr websocketpp
git clone https://github.com/zaphoyd/websocketpp.git
cd websocketpp
git checkout a6d2c325b16ebdbd5b2e746f9a9692176ccf218d
CFLAGS=-fPIC CPPFLAGS=-fPIC CXXFLAGS=-fPIC BOOST_PREFIX="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" prefix="${EXTERNAL_LIBRARY_DIR}/websocketpp_matiasperez" make install
cd ..
