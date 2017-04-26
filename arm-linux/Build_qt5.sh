# Qt5 [libc++]
# ============


src_dir=$1
ins_dir=$2
cd src/${src_dir}

export QT_SRC_DIR=$(pwd)
QT_DEVICE=linux-leap-lmvp-g++
QT_QPA_PLATFORM=xcb

cp -vr ../../arm-linux/mkspecs/* qtbase/mkspecs/

#-no-feature-pdf added because the module is broken in GCC 4.8.
VERBOSE=1 QMAKE_CFLAGS_SHLIB="-fPIC" QMAKE_CFLAGS_STATIC_LIB="-fPIC" \
QMAKE_CC=${CC} QMAKE_CXX=${CXX} OPENSSL_LIBS="-lssl -lcrypto -ldl" \
./configure -prefix "${ins_dir}" -opensource -confirm-license -release \
 -device ${QT_DEVICE} -device-option CROSS_COMPILE=${CROSS_COMPILER_PREFIX} \
 -device-option COMPILE_VERSION=5 \
 -no-icu -nomake examples -nomake tests \
 -openssl-linked -I "${OPENSSL_PATH}/include" -L "${OPENSSL_PATH}/lib" \
 -qt-libjpeg -qt-libpng -skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcanvas3d \
 -skip qtconnectivity -skip qtdeclarative -skip qtdoc -skip qtdocgallery \
 -skip qtenginio -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects \
 -skip qtimageformats -skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtpim \
 -skip qtpurchasing -skip qtquick1 -skip qtquickcontrols -skip qtquickcontrols2 \
 -skip qtrepotools -skip script -skip qtsensors -skip qtserialbus -skip qtserialport \
 -skip qtsvg -skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebkit \
 -skip qtwebkit-examples -skip qtx11extras -skip qtxmlpatterns \
 -qt-xcb -verbose \
 -no-feature-pdf \
 && make -j 9 VERBOSE=1 &&
make -j1 install

rm -fr ${ins_dir}/doc
rm -fr ${ins_dir}/examples
cd ..

