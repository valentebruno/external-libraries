#!/bin/sh
# Build and install all of the Leap dependent libraries
# websocketpp
# ====================


src_dir=$1
ins_dir=$2
cd src/${src_dir}

CPP11_='-arch x86_64 -stdlib=libc++ -mmacosx-version-min=10.10 -fvisibility=hidden -fvisibility-inlines-hidden' BOOST_PREFIX="${BOOST_PATH}" prefix="${ins_dir}" make install
