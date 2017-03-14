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
if [ "${MACHINE}" = "x86_64" ]; then
  JDK_ARCH="amd64"
else
  JDK_ARCH="i686"
fi
cp -R /usr/lib/jvm/java-1.8.0-openjdk-${JDK_ARCH}/include/* "${EXTERNAL_LIBRARY_DIR}/jdk/include/"

# Python
# ======

PYTHON_VERSION="2.7.11"
PYTHON_VERSION_MAJOR_MINOR="2.7"
rm -f Python-${PYTHON_VERSION}.tar.xz
wget http://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz
rm -fr Python-${PYTHON_VERSION}
tar xf Python-${PYTHON_VERSION}.tar.xz
cd Python-${PYTHON_VERSION}
cat <<EOF > config.site
ac_cv_file__dev_ptmx=no
ac_cv_file__dev_ptc=no
EOF
CONFIG_SITE=config.site CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ ./configure --host=aarch64-linux-gnu --build=x86_64-linux-gnu --prefix="${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}" --disable-shared --disable-ipv6 CFLAGS="-fPIC" LDFLAGS="-fPIC"
make -j 4 && make install
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/bin"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/share"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/lib/python${PYTHON_VERSION_MAJOR_MINOR}"
cd ..
