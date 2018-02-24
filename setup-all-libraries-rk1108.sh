#!/bin/bash
export EXT_LIB_INSTALL_ROOT="/opt/local/Libraries-rk1108"
source log-output.sh

export HOST_LIB_ROOT="$(cd ..; pwd)/Libraries-x64"

export BUILD_TYPE=rk1108
export BUILD_ARCH=x86

export TOOLCHAIN_FILE=$(pwd)/toolchain-rk1108.cmake
export CROSS_COMPILER_PREFIX=/opt/rk1108_toolchain/usr/bin/arm-linux-
export HOST="arm-linux"
export CC=${CROSS_COMPILER_PREFIX}gcc
export CXX=${CROSS_COMPILER_PREFIX}g++
export AR=${CROSS_COMPILER_PREFIX}ar
export LD=${CROSS_COMPILER_PREFIX}ld
export STRIP=${CROSS_COMPILER_PREFIX}arm-linux-strip

export CFLAGS="-O3 -fPIC -fvisibility=hidden -fvisibility-inlines-hidden -fno-omit-frame-pointer"
export CXXFLAGS="${CFLAGS} -std=c++11 -mfpu=neon"

RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
export CMAKE_ADDITIONAL_ARGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}"

source ./setup-library.sh

#setup-library https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2 1.64.0 -s "boost_1_64_0" -o "boost_1_64_0" -n "boost"
setup-library git@github.com:madler/zlib.git 1.2.8 -g
#setup-library git@github.com:openssl/openssl.git 1.0.2k -g -b "OpenSSL_1_0_2k"
#export OPENSSL_ROOT_DIR=${OPENSSL_PATH}
#
#setup-library https://curl.haxx.se/download/curl-7.53.1.tar.gz 7.53.1 -n curl -o "curl-7.53.1" -s "curl-7.53.1"
setup-library git@github.com:google/flatbuffers.git 1.8.0 -g 
setup-library git@github.com:google/protobuf.git 3.5.1 -g
#
#if [[ ${SKIP_QT_BUILD} != true ]]; then
#  setup-library http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz 5.9.0 -s "qt-everywhere-opensource-src-5.9.0" -n "qt5" -o "qt-5.9.0"
#fi
#
#setup-library git@github.com:leapmotion/upgrade_tool.git 0.0.1 -g -b "fix-narrowing"
#setup-library git@github.com:leapmotion/autowiring.git 1.0.5 -g
#setup-library git@github.com:leapmotion/leapserial.git 0.5.1 -g
#setup-library git@github.com:leapmotion/leaphttp.git 0.1.3 -g
#setup-library git@github.com:leapmotion/leapipc.git 0.1.7 -g
#setup-library git@github.com:leapmotion/leapresource.git 0.1.3 -g
#setup-library git@github.com:leapmotion/libxs.git 1.2.0 -g -b "leap"
#setup-library git@github.com:zaphoyd/websocketpp.git 0.8.0 -g -b "develop" #technically 0.8.0-dev
#
#setup-library https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_29_1_RTM/src/nss-3.29.1-with-nspr-4.13.1.tar.gz 3.29.1 -s "nss-3.29.1" -o "nss-3.29.1" -n "nss"
#setup-library https://www.libsdl.org/release/SDL2-2.0.1.tar.gz 2.0.1 -s SDL2-2.0.1 -n "sdl2" -o "SDL2-2.0.1"
#setup-library https://sourceforge.net/projects/glew/files/glew/1.13.0/glew-1.13.0.tgz 1.13.0 -s "glew-1.13.0" -o "glew-1.13.0" -n "glew"
#setup-library git@github.com:leapmotion/FreeImage.git 3.17.0 -g -n "freeimage"
#setup-library git@github.com:leapmotion/anttweakbar.git 1.16 -g -b "develop"
#setup-library git://git.sv.nongnu.org/freetype/freetype2.git 2.6.3 -b VER-2-6-3 -o "freetype-2.6.3"
#setup-library git@github.com:rougier/freetype-gl.git 0.0.1 -g -b @f2edab9 -n freetypegl
#setup-library git@github.com:assimp/assimp.git 3.2 -g
#
#setup-library https://chromium.googlesource.com/breakpad/breakpad 0.1 -g -b "chrome_64"
#
#EIGEN_VERSION=3.3.1
#setup-library http://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.gz ${EIGEN_VERSION} -o "eigen-${EIGEN_VERSION}" -s "eigen-eigen-f562a193118d" -n eigen
#setup-library git@github.com:memononen/nanosvg.git 1.0.0 -g -b "master"
#setup-library git@github.com:opencv/opencv.git 3.2 -g -b "3.2.0"
#setup-library git@github.com:ivanfratric/polypartition.git 1.0.0 -g -b "@cb9a41b"
#
##For now, we depend on the jdk being located exactly here
#if [[ ! -d ${EXT_LIB_INSTALL_ROOT}/jdk ]]; then
#  echo "Copying JDK..."
#  cp -r /usr/lib/jvm/java-8-openjdk-arm64 ${EXT_LIB_INSTALL_ROOT}/jdk
#fi

