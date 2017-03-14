#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

if [ "${MACHINE}" = "x86_64" ]; then
    EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}-arm64
    COMPILER=aarch64-linux-gnu-g++
elif [ "${MACHINE}" = "i386" ]; then
    # if explicitly specified on a 64-bit machine, use another dir
    EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}-arm32
    ADDITINAL_ARGS="address-model=32 architecture=x86"
    COMPILER=arm-linux-gnueabihf-g++
fi

# Boost 1.63
# ==========

BOOST_VERSION="1_63_0"
BOOST_VERSION_DOT="1.63.0"
#rm -f boost_${BOOST_VERSION}.tar.bz2
#wget "http://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2"
#rm -fr boost_${BOOST_VERSION}
#tar xfj "boost_${BOOST_VERSION}.tar.bz2"
cd boost_${BOOST_VERSION}
rm -fr /tmp/boost
./bootstrap.sh
sed -i "s/using gcc ;/using gcc : arm : ${COMPILER} ;/" project-config.jam
./b2 --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" --build-dir=/tmp link=static threading=multi variant=release cflags="-fPIC" cxxflags="-fPIC" toolset=gcc-arm target-os=linux ${ADDITIONAL_ARGS} --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread --with-regex install
cd ..
