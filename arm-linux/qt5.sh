#!/bin/bash -e
# Qt5
# ============

export QT_SRC_DIR=$(pwd)/src/$1
QT_DEVICE=linux-leap-lmvp-g++
QT_QPA_PLATFORM=xcb

cp -vr arm-linux/mkspecs/* src/$1/qtbase/mkspecs/

#-no-feature-pdf added because the module is broken in GCC 4.8.
export QMAKE_CC=${CC}
export QMAKE_CXX=${CXX}
export OPENSSL_LIBS="-L${OPENSSL_PATH}/lib -lssl -lcrypto -ldl"
export qt_additional_args="-device ${QT_DEVICE} \
-device-option CROSS_COMPILE=${CROSS_COMPILER_PREFIX} -device-option COMPILE_VERSION=5 \
-openssl-linked -I${OPENSSL_PATH}/include -qt-libjpeg -qt-libpng -qt-xcb -no-feature-pdf"

source posix/$(basename $0)
