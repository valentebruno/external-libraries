#!/bin/bash

# LeapHTTP
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake ../ -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
 -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}" \
 -DCMAKE_PREFIX_PATH:STRING="${CURL_PATH}" \
 -DCURL_ROOT_DIR:FILEPATH="${CURL_PATH}" \
 -DZLIB_ROOT_DIR:PATH="${ZLIB_PATH}" \
 -DOPENSSL_USE_STATIC_LIBS:BOOL=ON

cmake --build . --target install --config Debug
cmake --build . --target install --config Release
