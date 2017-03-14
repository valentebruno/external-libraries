#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

cd src

# Boost 1.55
# ===================

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"

# websocketpp
# ====================

rm -fr websocketpp
git clone git@github.com:leapmotion/websocketpp.git
cd websocketpp
CPP11_='-arch x86_64 -arch i386 -stdlib=libc++ -mmacosx-version-min=10.7 -fvisibility=hidden -fvisibility-inlines-hidden' BOOST_PREFIX="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" prefix="${EXTERNAL_LIBRARY_DIR}/websocketpp-0.7.0" make install
cd ..

cd ..
