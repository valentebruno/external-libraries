#!/bin/bash

# LeapHTTP
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.10" \
 -Dautowiring_DIR:PATH="${AUTOWIRING_PATH}" -DZLIB_ROOT_DIR:PATH="${ZLIB_PATH}" \
 -DCMAKE_PREFIX_PATH:STRING="${CURL_PATH}" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64"
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
