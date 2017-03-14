#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

if [ -z "${MACHINE}" ]; then
  MACHINE=`uname -m`
elif [ "${MACHINE}" = "i386" ]; then
  # if explicitly specified on a 64-bit machine, use another dir
  EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}-x86
fi
if [ "${MACHINE}" = "x86_64" ]; then
  ARCH_FLAGS=""
else
  ARCH_FLAGS="-m32"
fi

# libusb
# ======

rm -fr libusb
git clone --branch leap-2.2.x git@sf-github.leap.corp:leapmotion/libusb.git
cd libusb
./bootstrap.sh
./configure --disable-udev CFLAGS="-O3 ${ARCH_FLAGS}"
make
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.so.0.1.0 ${EXTERNAL_LIBRARY_DIR}/libusb/lib/libusb-1.0.0.so
cd ..

# libuvc
# ======

rm -fr libuvc
git clone git@sf-github.leap.corp:leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb" -DCMAKE_C_FLAGS="-fPIC -O3"
make && make install
cd ..
rm -fr Build
cd ..

# Boost 1.55
# ==========

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"
curl -O "http://superb-dca2.dl.sourceforge.net/project/boost/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2"
rm -fr boost_${BOOST_VERSION}
tar xfj "boost_${BOOST_VERSION}.tar.bz2"
cd boost_${BOOST_VERSION}
rm -fr /tmp/boost
./bootstrap.sh
./b2 --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" --build-dir=/tmp link=static threading=multi variant=release cflags=-fPIC cxxflags=-fPIC --without-mpi --without-python install
cd ..

# Crossroads (libxs)
# ==================

XS_VERSION="1.2.0"
rm -fr libxs
git clone --depth 1 --branch leap https://github.com/leapmotion/libxs.git
cd libxs
./autogen.sh
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/libxs-${XS_VERSION}" --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE"
make && make install
cd ..

# Protocol Buffers (protobuf)
# ===========================

PROTOBUF_VERSION="2.5.0"
curl -O http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VERSION}.tar.bz2
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfj protobuf-${PROTOBUF_VERSION}.tar.bz2
cd protobuf-${PROTOBUF_VERSION}
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}" --enable-static --disable-shared CXXFLAGS="-fPIC -O2 -D_THREAD_SAFE -fvisibility=hidden"
make && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}"; ln -s include src)
cd ..

# zlib
# ====

ZLIB_VERSION="1.2.8"
curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
rm -fr zlib-${ZLIB_VERSION}
tar xfz zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CFLAGS="-fPIC -O3" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make && make install
cd ..

# OpenSSL
# =======

OPENSSL_VERSION="1.0.0j"
curl -O http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
rm -fr openssl-${OPENSSL_VERSION}
tar xfz openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
if [ "${MACHINE}" == "x86_64" ]; then
  OPENSSL_OS="linux-x86_64"
else
  OPENSSL_OS="linux-generic32"
fi
./Configure -fPIC --prefix="${EXTERNAL_LIBRARY_DIR}/openssl" ${OPENSSL_OS} no-asm enable-static-engine
make && make install
cd ..

# cURL
# ====

CURL_VERSION="7.34.0"
curl -O "http://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2"
rm -fr curl-${CURL_VERSION}
tar xfj "curl-${CURL_VERSION}.tar.bz2"
cd "curl-${CURL_VERSION}"
PKG_CONFIG_PATH="${EXTERNAL_LIBRARY_DIR}/openssl/lib/pkgconfig" LDFLAGS="-ldl" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/curl-${CURL_VERSION}" --with-zlib="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/" --with-ssl --without-ca-path --without-ca-bundle --without-libidn --disable-dict --disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http --enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps --disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps --disable-telnet --disable-tftp --disable-shared --enable-optimize --disable-debug --enable-symbol-hiding || exit
make -j 4 && make install
cd ..

# websocketpp
# ===========
#
# FIXME: We now use https://github.com/leapmotion/websocketpp/commits/leap

rm -fr websocketpp
git clone https://github.com/zaphoyd/websocketpp.git
cd websocketpp
git checkout -b version a6d2c325b16ebdbd5b2e746f9a9692176ccf218d
patch -p0 <<"BOOST_LOCK_GUARD"
--- src/messages/data.hpp
+++ src/messages/data.hpp
@@ -37,6 +37,7 @@
 #include <boost/function.hpp>
 #include <boost/intrusive_ptr.hpp>
 #include <boost/thread/mutex.hpp>
+#include <boost/thread/lock_guard.hpp>
 #include <boost/utility.hpp>
 
 #include <algorithm>
BOOST_LOCK_GUARD
BOOST_PREFIX="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}" prefix="${EXTERNAL_LIBRARY_DIR}/websocketpp" make install
cd ..

# Eigen
# =====

EIGEN_VERSION="3.1.2"
EIGEN_HASH="5097c01bcdc4"
curl -O https://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.bz2
rm -fr eigen-eigen-${EIGEN_HASH}
tar xfj ${EIGEN_VERSION}.tar.bz2
mkdir -p "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported"
cp -R eigen-eigen-${EIGEN_HASH}/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/"
cp -R eigen-eigen-${EIGEN_HASH}/unsupported/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported/"

# JDK
# ===

mkdir -p "${EXTERNAL_LIBRARY_DIR}/jdk/include"
if [ "${MACHINE}" == "x86_64" ]; then
  JDK_ARCH="x86_64"
else
  JDK_ARCH="i686"
fi
cp -R /usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.${JDK_ARCH}/include/* "${EXTERNAL_LIBRARY_DIR}/jdk/include/"

# Python
# ======

PYTHON_VERSION="2.7.3"
PYTHON_VERSION_MAJOR_MINOR="2.7"
curl -O http://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.bz2
rm -fr Python-${PYTHON_VERSION}
tar xfj Python-${PYTHON_VERSION}.tar.bz2
cd Python-${PYTHON_VERSION}
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}" --disable-shared CFLAGS="-fPIC" CPPFLAGS="-fPIC" LDFLAGS="-fPIC"
make -j 4 && make install
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/bin"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/share"
rm -fr "${EXTERNAL_LIBRARY_DIR}/python${PYTHON_VERSION_MAJOR_MINOR}/lib/python${PYTHON_VERSION_MAJOR_MINOR}"
cd ..

# Qt
# ==

QT_VERSION="4.8.4"
curl -O http://releases.qt-project.org/qt4/source/qt-everywhere-opensource-src-${QT_VERSION}.tar.gz
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
echo yes | QMAKE_CFLAGS_SHLIB="-fPIC" QMAKE_CFLAGS_STATIC_LIB="-fPIC" QMAKE_LIBS="-ldl" OPENSSL_LIBS="-L${EXTERNAL_LIBRARY_DIR}/openssl/lib -lssl -lcrypto -ldl" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}" -opensource -platform ${QT_PLATFORM} -release -no-ssse3 -no-sse4.1 -no-sse4.2 -no-avx -no-neon -no-qt3support -no-phonon -no-multimedia -webkit ${QT_DBUS} -plugindir ${QT_PLUGIN_DIR} -openssl-linked -I "${EXTERNAL_LIBRARY_DIR}/openssl/include" && make -j 4 && make install
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/demos
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/doc
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/examples
cd ..

# OpenCV
# ======

OPENCV_VERSION="2.4.2"
curl -O http://iweb.dl.sourceforge.net/project/opencvlibrary/opencv-unix/${OPENCV_VERSION}/OpenCV-${OPENCV_VERSION}.tar.bz2
rm -fr OpenCV-${OPENCV_VERSION}
tar xfj OpenCV-${OPENCV_VERSION}.tar.bz2
cd OpenCV-${OPENCV_VERSION}
mkdir -p Build
cd Build
cmake .. -DBUILD_DOCS:BOOL=OFF -DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/OpenCV" -DEIGEN_INCLUDE_PATH:PATH="${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}" -DWITH_CUDA:BOOL=OFF -DWITH_TBB:BOOL=OFF -DWITH_QT:BOOL=ON -DQT_QMAKE_EXECUTABLE:FILEPATH="${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/bin/qmake"
make && make install
cd ..
rm -fr Build
cd ..

# freeglut
# ========

FREEGLUT_VERSION="2.8.0"
curl -O http://iweb.dl.sourceforge.net/project/freeglut/freeglut/${FREEGLUT_VERSION}/freeglut-${FREEGLUT_VERSION}.tar.gz
rm -fr freeglut-${FREEGLUT_VERSION}
tar xfz freeglut-${FREEGLUT_VERSION}.tar.gz
cd freeglut-${FREEGLUT_VERSION}
patch -p0 <<"FREEGLUT_NO_XRANDR_XF86VM"
--- configure.old	2013-02-12 13:02:05.517823000 -0800
+++ configure	2013-02-12 13:00:48.160776000 -0800
@@ -12229,6 +12229,7 @@
 else
   ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 fi
+ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12274,6 +12275,7 @@
 else
   ac_cv_lib_Xrandr_XRRQueryExtension=no
 fi
+ac_cv_lib_Xrandr_XRRQueryExtension=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12550,6 +12552,8 @@
 $as_echo "#define TIME_WITH_SYS_TIME 1" >>confdefs.h
 
 fi
+ac_cv_header_X11_extensions_xf86vmode_h=no
+ac_cv_header_X11_extensions_Xrandr_h=no
 
 for ac_header in X11/extensions/xf86vmode.h
 do :
FREEGLUT_NO_XRANDR_XF86VM
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}" CPPFLAGS="-fPIC"
make && make install
cd ..

# bullet
# ======

BULLET_VERSION="2.84"
git clone git@github.com:bulletphysics/bullet3.git bullet-${BULLET_VERSION}
cd bullet-${BULLET_VERSION}
git fetch
git checkout df3ddaca5eb
git clean -df

CXXFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden -fPIC" cmake -DCMAKE_BUILD_TYPE:STRING=Release -DGLUT_glut_LIBRARY:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/lib" -DGLUT_INCLUDE_DIR:PATH="${EXTERNAL_LIBRARY_DIR}/freeglut-${FREEGLUT_VERSION}/include" -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}" -DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF -DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF -DBUILD_UNIT_TESTS:BOOL=OFF
make -j 4 && make install
cd ..

# glew
# ====

GLEW_VERSION="1.9.0"
curl -O http://iweb.dl.sourceforge.net/project/glew/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.tgz
rm -fr glew-${GLEW_VERSION}
tar xfz glew-${GLEW_VERSION}.tgz
cd glew-${GLEW_VERSION}
GLEW_DEST="${EXTERNAL_LIBRARY_DIR}/glew-${GLEW_VERSION}" make install
cd ..

# AntTweakBar
# ===========

curl -O http://www.antisphere.com/Tools/AntTweakBar/AntTweakBar_115.zip
rm -fr AntTweakBar
unzip -x AntTweakBar_115.zip
cd AntTweakBar/src
make
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
cp -R ../include/* "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/include/"
cp ../lib/libAntTweakBar.so "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"
(cd "${EXTERNAL_LIBRARY_DIR}/AntTweakBar/lib"; ln -s libAntTweakBar.so libAntTweakBar.so.1)
cd ../..

# LuaJIT
# ======

LUAJIT_VERSION="2.0.1"
curl -O http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
rm -fr LuaJIT-${LUAJIT_VERSION}
tar xfz LuaJIT-${LUAJIT_VERSION}.tar.gz
cd LuaJIT-${LUAJIT_VERSION}
if [ ! -x Makefile.orig ]; then
  mv Makefile Makefile.orig
fi
sed -e "s#PREFIX= /usr/local#PREFIX= ${EXTERNAL_LIBRARY_DIR}/luajit#" Makefile.orig > Makefile
make clean
make CFLAGS="-O3 ${ARCH_FLAGS}" LDFLAGS="${ARCH_FLAGS}" BUILDMODE=static -j 4 && make install
cd ..

# xdotool
# =======

XDOTOOL_VERSION="2.20110530.1"
curl -O http://semicomplete.googlecode.com/files/xdotool-${XDOTOOL_VERSION}.tar.gz
rm -fr xdotool-${XDOTOOL_VERSION}
tar xfz xdotool-${XDOTOOL_VERSION}.tar.gz
cd xdotool-${XDOTOOL_VERSION}
patch -p0 <<"CLASS_TO_CLAZZ"
--- xdo.h	2011-05-29 23:36:04.000000000 -0700
+++ xdo.h	2013-04-02 10:20:24.344724334 -0700
@@ -527,7 +527,7 @@
  * @param class The new class. If NULL, no change.
  */
 int xdo_window_setclass(const xdo_t *xdo, Window wid, const char *name,
-                        const char *class);
+                        const char *clazz);
 
 /**
  * Sets the urgency hint for a window.
CLASS_TO_CLAZZ
PREFIX=${EXTERNAL_LIBRARY_DIR}/xdotool make libxdo.a
strip --strip-debug libxdo.a
mkdir -p ${EXTERNAL_LIBRARY_DIR}/xdotool/include
mkdir -p ${EXTERNAL_LIBRARY_DIR}/xdotool/lib
install xdo.h ${EXTERNAL_LIBRARY_DIR}/xdotool/include/xdo.h
install libxdo.a ${EXTERNAL_LIBRARY_DIR}/xdotool/lib/libxdo.a
cd ..

# Breakpad
# ========

BREAKPAD_VERSION=0.1
rm -fr breakpad-${BREAKPAD_VERSION}
svn checkout http://google-breakpad.googlecode.com/svn/trunk/ breakpad-${BREAKPAD_VERSION}
cd breakpad-${BREAKPAD_VERSION}
BREAKPAD_FLAGS=""
if [ "${MACHINE}" = "i386" ]; then
  BREAKPAD_fLAGS="--enable-m32"
fi
./configure --prefix="${EXTERNAL_LIBRARY_DIR}"/breakpad-${BREAKPAD_VERSION} ${BREAKPAD_FLAGS}
make && make install
BREAKPAD_INCLUDE="${EXTERNAL_LIBRARY_DIR}/breakpad-${BREAKPAD_VERSION}/include"
cd src
for f in $(find client common google_breakpad processor testing third_party -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
# fix breakpad for C++11: https://code.google.com/p/google-breakpad/issues/detail?id=481
patch -p1 "${BREAKPAD_INCLUDE}"/client/linux/minidump_writer/linux_dumper.h < ../../linux_dumper.h.diffs
cd ../..
