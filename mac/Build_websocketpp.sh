#!/bin/sh
# Build and install all of the Leap dependent libraries
# websocketpp
# ====================


src_dir=$1
ins_dir=$2
cd src/${src_dir}

cmake . -DCMAKE_INSTALL_PREFIX:PATH=${ins_dir} -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.10" \
-DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DBOOST_PREFIX="${BOOST_PATH}"
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
