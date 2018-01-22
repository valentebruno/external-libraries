#!/bin/bash
# LeapHTTP
# ====

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

build_cmake_lib "${ins_dir}" -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}" -DZLIB_ROOT_DIR:PATH="${ZLIB_PATH}" \
 -DCMAKE_PREFIX_PATH:STRING="${CURL_PATH}" \
 -DCURL_INCLUDE_DIR:PATH="${CURL_PATH}/include" \
 -DCURL_LIBRARY:FILEPATH="${CURL_PATH}/lib/libcurl.a" \
 -DOPENSSL_ROOT_DIR:PATH="${OPENSSL_PATH}"

