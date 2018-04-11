#!/bin/bash -e

if [[ ! $EXT_LIB_INSTALL_ROOT ]]; then
  echo "EXT_LIB_INSTALL_ROOT must be defined."
  exit 1
fi

source ./setup-library.sh
setup-library https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2 1.64.0 -s "boost_1_64_0" -o "boost_1_64_0" -n "boost"
setup-library git@github.com:madler/zlib.git 1.2.8 -g
setup-library git@github.com:openssl/openssl.git 1.0.2k -g -b "OpenSSL_1_0_2k"
export OPENSSL_ROOT_DIR=${OPENSSL_PATH}

setup-library https://curl.haxx.se/download/curl-7.53.1.tar.gz 7.53.1 -n curl -o "curl-7.53.1" -s "curl-7.53.1"
setup-library git@github.com:google/flatbuffers.git 1.8.0 -g
setup-library git@github.com:google/protobuf.git 3.0.2 -g

if [[ ${SKIP_QT_BUILD} != true ]]; then
  setup-library http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz 5.9.0 -s "qt-everywhere-opensource-src-5.9.0" -n "qt5" -o "qt-5.9.0"
fi

setup-library git@github.com:leapmotion/upgrade_tool.git 0.0.2 -g
setup-library git@github.com:leapmotion/autowiring.git 1.1.0 -g
setup-library git@github.com:leapmotion/leapserial.git 0.5.1 -g
setup-library git@github.com:leapmotion/leaphttp.git 0.1.3 -g
setup-library git@github.com:leapmotion/leapipc.git 0.1.7 -g
setup-library git@github.com:leapmotion/leapresource.git 0.1.3 -g
setup-library git@github.com:leapmotion/libxs.git 1.2.0 -g -b "leap"
setup-library git@github.com:zaphoyd/websocketpp.git 0.8.0 -g -b "develop" #technically 0.8.0-dev

setup-library https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_29_1_RTM/src/nss-3.29.1-with-nspr-4.13.1.tar.gz 3.29.1 -s "nss-3.29.1" -o "nss-3.29.1" -n "nss"
setup-library https://www.libsdl.org/release/SDL2-2.0.1.tar.gz 2.0.1 -s SDL2-2.0.1 -n "sdl2" -o "SDL2-2.0.1"
setup-library https://sourceforge.net/projects/glew/files/glew/1.13.0/glew-1.13.0.tgz 1.13.0 -s "glew-1.13.0" -o "glew-1.13.0" -n "glew"
setup-library git@github.com:leapmotion/FreeImage.git 3.17.0 -g -n "freeimage"
setup-library git@github.com:leapmotion/anttweakbar.git 1.16 -g -b "develop"
setup-library git://git.sv.nongnu.org/freetype/freetype2.git 2.6.3 -b VER-2-6-3 -o "freetype-2.6.3"
setup-library git@github.com:rougier/freetype-gl.git 0.0.1 -g -b @f2edab9 -n freetypegl
setup-library git@github.com:assimp/assimp.git 3.2 -g

setup-library https://chromium.googlesource.com/breakpad/breakpad 0.1 -g -b "chrome_64"

EIGEN_VERSION=3.3.1
setup-library http://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.gz ${EIGEN_VERSION} -o "eigen-${EIGEN_VERSION}" -s "eigen-eigen-f562a193118d" -n eigen
setup-library git@github.com:memononen/nanosvg.git 1.0.0 -g -b "master"
setup-library git@github.com:opencv/opencv.git 3.2 -g -b "3.2.0"
setup-library git@github.com:ivanfratric/polypartition.git 1.0.0 -g -b "@cb9a41b"
