#!/bin/bash

if [ ! -d src ]; then
  mkdir src
fi
cd src

function download_git {
  url=$1
  branch=$2

  git clone ${url} --depth 1 --recursive ${branch:+--branch ${branch}}
}

function download_curl {
  url=$1
  filename=$(basename ${url})
  curl -OL ${url}
  7z x ${filename}
  rm -f ${filename}
}

function download {
  foldername=$1
  url=$2
  shift

  if [[ -e ${foldername} ]]; then
    return
  fi

  if  [[ ${url} == git* ]]; then
    download_git $@
  else
    download_curl $@
  fi
}

QT_URL=git://code.qt.io/qt/qt5.git
JOM_URL=http://download.qt.io/official_releases/jom/jom.zip
BOOST_URL=http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.7z
OPENSSH_URL=git@github.com:openssl/openssl.git
CURL_URL=git@github.com:curl/curl.git
ICU_URL=http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.zip
ZLIB_URL=git@github.com:madler/zlib.git
FLATBUFFERS_URL=git@github.com:google/flatbuffers.git
PROTOBUF_URL=git@github.com:google/protobuf.git
LEAPSERIAL_URL=git@github.com:leapmotion/leapserial.git
CROSSROADS_URL=git@github.com:crossroads-io/libxs.git

download qt5 ${QT_URL} 5.6
download jom.exe ${JOM_URL}
download boost_1_60_0 ${BOOST_URL} boost_1_60_0
download curl ${CURL_URL} curl-7_48_0
download openssl ${OPENSSH_URL} OpenSSL_1_0_2g
download icu ${ICU_URL}
download zlib ${ZLIB_URL} v1.2.8
download flatbuffers ${FLATBUFFERS_URL} v1.3.0
download protobuf ${PROTOBUF_URL} v2.6.1
download leapserial ${LEAPSERIAL_URL} v0.3.2
download libxs ${CROSSROADS_URL} v1.2.0
