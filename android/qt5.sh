#!/bin/bash -e
# Qt5 [libc++]
# ============

export QT_SRC_DIR=${BUILD_DIR}/$1

cp -vr arm-linux/mkspecs/* ${BUILD_DIR}/$1/qtbase/mkspecs/

export QMAKE_CC=${CC}
export QMAKE_CXX=${CXX}
export OPENSSL_LIBS="-lssl -lcrypto -ldl"

export qt_additional_args="-xplatform android-g++ \
 -android-ndk ${NDK_PATH} -android-sdk ${ANDROID_SDK_PATH} \
 -android-ndk-host linux-x86_64 \
 -android-toolchain-version ${COMPILER_VERSION} \
 -openssl-linked -I \"${OPENSSL_PATH}/include\" -L \"${OPENSSL_PATH}/lib\" \
 -qt-libjpeg -qt-libpng -qt-xcb -no-feature-pdf"

source posix/$(basename $0)

