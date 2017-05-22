#!/bin/bash -e
# LeapHTTP
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} \
 -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}" -DZLIB_ROOT_DIR:PATH="${ZLIB_PATH}" \
 -DCMAKE_PREFIX_PATH:STRING="${CURL_PATH}" \
 -DCURL_INCLUDE_DIR:PATH="${CURL_PATH}/include" \
 -DCURL_LIBRARY:FILEPATH="${CURL_PATH}/lib/libcurl.a" \
 -DOPENSSL_ROOT_DIR:PATH="${OPENSSL_PATH}" ${CMAKE_ADDITIONAL_ARGS}
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
