#!/bin/sh -xe
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
fi
ARCH_FLAGS=""

# JDK
# ===

mkdir -p "${EXTERNAL_LIBRARY_DIR}/jdk/include"
if [ "${MACHINE}" == "x86_64" ]; then
  JDK_ARCH="x86_64"
else
  JDK_ARCH="i686"
fi
cp -R /usr/lib/jvm/java-1.7.0-openjdk-amd64/include/* "${EXTERNAL_LIBRARY_DIR}/jdk/include/"

# Python
# ======

PYTHON_VERSION="2.7.11"
PYTHON_VERSION_MAJOR_MINOR="2.7"
#curl -O https://www.python.org/ftp/python/2.7.11/Python-${PYTHON_VERSION}.tgz
rm -fr Python-${PYTHON_VERSION}
tar xfz Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}
cat > config.site <<"CONFIG"
ac_cv_file__dev_ptmx=no
ac_cv_file__dev_ptc=no
CONFIG
./configure --host=aarch64-linux --build=i686-pc-linux-gnu CC=aarch64-linux-gnu-gcc --prefix="${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}" --disable-shared --disable-ipv6 CFLAGS="-fPIC" CPPFLAGS="-fPIC" LDFLAGS="-fPIC" CONFIG_SITE=config.site
make -j 4 && make install
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/bin"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/share"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/lib/python${PYTHON_VERSION_MAJOR_MINOR}"
cd ..
