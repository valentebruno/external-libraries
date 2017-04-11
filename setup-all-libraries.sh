#!/bin/bash

if [[ ! $EXT_LIB_INSTALL_ROOT ]]; then
  echo "EXT_LIB_INSTALL_ROOT must be defined."
  exit 1
fi

./setup-library.sh http://downloads.sourceforge.net/project/boost/boost/1.63.0/boost_1_63_0.tar.gz 1.63.0 -s "boost_1_63_0" -o "boost_1_63_0" -n "boost"
export BOOST_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/boost_1_63_0)
./setup-library.sh git@github.com:madler/zlib.git 1.2.8
export ZLIB_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/zlib-1.2.8)
./setup-library.sh git@github.com:openssl/openssl.git 1.0.2k
export OPENSSL_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/openssl-1.0.2k)
export OPENSSL_ROOT_DIR=${OPENSSL_PATH}
./setup-library.sh http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.zip 57.1 -s "icu" -o "icu-57.1" -n "icu"
export ICU_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/icu-57.1)
./setup-library.sh https://curl.haxx.se/download/curl-7.53.1.zip 7.53.1 -n curl -o "curl-7.53.1"
export CURL_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/curl-7.53.1)
./setup-library.sh git://code.qt.io/qt/qt5.git 5.8.0 -o "qt-5.8.0"

./setup-library.sh git@github.com:google/flatbuffers.git 1.3.0
./setup-library.sh git@github.com:google/protobuf.git 3.0.0

if [[ $BUILD_ARCH == "x64" ]]; then
  suffix=-win64
fi

./setup-library.sh git@github.com:leapmotion/autowiring.git 1.0.3 -o autowiring-1.0.3$suffix
export AUTOWIRING_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/autowiring-1.0.3$suffix)
./setup-library.sh git@github.com:leapmotion/leapserial.git 0.4.0 -o LeapSerial-0.4.0$suffix
export LEAPSERIAL_PATH=$(cygpath -w ${EXT_LIB_INSTALL_ROOT}/LeapSerial-0.4.0$suffix)
./setup-library.sh git@github.com:leapmotion/leaphttp.git 0.1.1 -o LeapHTTP-0.1.1$suffix
./setup-library.sh git@github.com:leapmotion/leapipc.git 0.1.4 -o LeapIPC-0.1.4$suffix
./setup-library.sh git@github.com:leapmotion/leapresource.git 0.1.0 -o LeapResource-0.1.0$suffix
./setup-library.sh git@github.com:leapmotion/libxs.git 1.2.0
./setup-library.sh git@github.com:dcnieho/FreeGLUT.git 3.0.0 -b FG_3_0_0
./setup-library.sh git@github.com:zaphoyd/websocketpp.git 0.7.0 -b0.7.0
./setup-library.sh https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_23_RTM/src/nss-3.23-with-nspr-4.12.tar.gz 3.23 -s "nss-3.23" -o "nss-3.23" -n "nss"
./setup-library.sh https://www.libsdl.org/release/SDL2-2.0.4.zip 2.0.4 -s "SDL2-2.0.4" -o "SDL2-2.0.4" -n "SDL2"
./setup-library.sh https://sourceforge.net/projects/glew/files/glew/1.13.0/glew-1.13.0.zip 1.13.0 -s "glew-1.13.0" -o "glew-1.13.0" -n "glew"
./setup-library.sh http://downloads.sourceforge.net/freeimage/FreeImage3170.zip 3.17.0 -s "FreeImage" -o "freeimage-3.17.0" -n "freeimage"
./setup-library.sh git@github.com:leapmotion/anttweakbar.git 1.16 -s "AntTweakBar" -b "develop"
./setup-library.sh git@github.com:bulletphysics/bullet3.git 2.84.0 -b @d5d8e16 -o "bullet-2.84.0"
./setup-library.sh git@github.com:leapmotion/DShowBaseClasses.git 1.0.0 -o "baseclasses-1.0.0"
./setup-library.sh git://git.sv.nongnu.org/freetype/freetype2.git 2.6.3 -b VER-2-6-3 -o "freetype-2.6.3"
./setup-library.sh git@github.com:rougier/freetype-gl.git 0.0.1 -b @a4cfb9a -n freetypegl
./setup-library.sh git@github.com:assimp/assimp.git 3.2
./setup-library.sh https://chromium.googlesource.com/external/gyp 0.1 -g -b "master"
./setup-library.sh https://chromium.googlesource.com/breakpad/breakpad 0.1 -g -b "master"

