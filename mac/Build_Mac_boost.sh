#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

# Boost 1.63 [libc++]
# ===================

BOOST_VERSION="1_63_0"
BOOST_VERSION_DOT="1.63.0"
if [ ! -f "boost_${BOOST_VERSION}.tar.bz2" ]; then
  wget "https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2"
fi
rm -fr boost_${BOOST_VERSION}
tar xfj boost_${BOOST_VERSION}.tar.bz2
cd boost_${BOOST_VERSION}

rm -fr /tmp/boost
./bootstrap.sh --with-toolset=clang
./b2 --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}-libc++" --build-dir=/tmp --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex link=static threading=multi variant=release cxxflags="-mmacosx-version-min=10.7 -arch x86_64 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden -stdlib=libc++" --without-mpi --without-python install

cd ..
