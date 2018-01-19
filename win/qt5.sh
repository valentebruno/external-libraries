#!/bin/bash -e

export ins_dir=$2
root_dir=$(pwd)

src_dir=${BUILD_DIR}/$1
cd ${src_dir}

export PATH="$(pwd)/qtbase/bin:$(pwd)/gnuwin32/bin:${PATH}"
mkdir -p build
cd build

../configure.bat -prefix "${ins_dir}" -opensource \
-confirm-license -debug-and-release -opengl desktop -no-angle -no-incredibuild-xge \
-platform win32-msvc${VS_VER_YEAR} -mp -openssl-linked -nomake examples -nomake tests -no-icu -no-dbus \
-skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcanvas3d \
-skip qtconnectivity -skip qtdeclarative -skip qtdoc -skip qtdocgallery \
-skip qtenginio -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects -skip qtimageformats \
-skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtpim -skip qtpurchasing \
-skip qtquick1 -skip qtquickcontrols -skip qtquickcontrols2 -skip qtrepotools \
-skip script -skip qtsensors -skip qtserialbus -skip qtserialport -skip qtsvg \
-skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebkit \
-skip qtwebkit-examples -skip qtx11extras -skip qtxmlpatterns \
-I "${OPENSSL_PATH}/include" -L "${OPENSSL_PATH}/lib" -I "${ZLIB_PATH}/include" \
OPENSSL_LIBS="-lUser32 -lAdvapi32 -lGdi32 -lWs2_32 -lWinmm -lWldap32 -lssleay32MD -llibeay32MD"

nmake
nmake install
