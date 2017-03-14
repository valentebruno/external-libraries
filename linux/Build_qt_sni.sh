#!/bin/sh -ex
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

MACHINE=`uname -m`
if [ "${MACHINE}" == "x86_64" ]; then
  ARCH_FLAGS="-m64"
else
  ARCH_FLAGS="-m32"
fi

# Qt
# ==

QT_VERSION="4.8.4"
rm -fr qt-everywhere-opensource-src-${QT_VERSION}
tar xfz qt-everywhere-opensource-src-${QT_VERSION}.tar.gz
if [ "${MACHINE}" == "x86_64" ]; then
  QT_PLATFORM=linux-g++-64
  QT_PLUGIN_DIR=/usr/lib/x86_64-linux-gnu/qt4/plugins
  QT_DBUS="-dbus"
else
  QT_PLATFORM=linux-g++-32
  QT_PLUGIN_DIR=/usr/lib/i386-linux-gnu/qt4/plugins
  QT_DBUS=
fi
cd qt-everywhere-opensource-src-${QT_VERSION}
patch -p1 < ${EXTERNAL_LIBRARY_DIR}/../qt-${QT_VERSION}-sni.diffs
echo yes | QMAKE_CFLAGS_SHLIB="-fPIC" QMAKE_CFLAGS_STATIC_LIB="-fPIC" QMAKE_LIBS="-ldl" OPENSSL_LIBS="-L${EXTERNAL_LIBRARY_DIR}/openssl/lib -lssl -lcrypto -ldl" ./configure -v --prefix="${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}" -opensource -platform ${QT_PLATFORM} -release -no-ssse3 -no-sse4.1 -no-sse4.2 -no-avx -no-neon -no-qt3support -no-phonon -no-multimedia -webkit ${QT_DBUS} -plugindir ${QT_PLUGIN_DIR} -openssl-linked -I "${EXTERNAL_LIBRARY_DIR}/openssl/include" && make -j 4
#mv /opt/local/Libraries/qt-4.8.4 /opt/local/Libaries/qt-4.8.4-old
QMAKE_CFLAGS_SHLIB="-fPIC" QMAKE_CFLAGS_STATIC_LIB="-fPIC" QMAKE_LIBS="-ldl" OPENSSL_LIBS="-L${EXTERNAL_LIBRARY_DIR}/openssl    /lib -lssl -lcrypto -ldl" make install
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/demos
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/doc
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/examples
cd ..
