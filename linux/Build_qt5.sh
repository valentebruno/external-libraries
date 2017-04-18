# Qt5 [libc++]
# ============

src_dir=$1
ins_dir=$2
cd src/${src_dir}

if [ "${BUILD_ARCH}" == "x64" ]; then
  QT_PLATFORM=linux-g++-64
  QT_PLUGIN_DIR=/usr/lib/x86_64-linux-gnu/qt5/plugins
  QT_DBUS="-dbus"
else
  QT_PLATFORM=linux-g++-32
  QT_PLUGIN_DIR=/usr/lib/i386-linux-gnu/qt5/plugins
  QT_DBUS=
fi

QMAKE_CFLAGS_SHLIB="-fPIC" QMAKE_CFLAGS_STATIC_LIB="-fPIC"
OPENSSL_LIBS="-L${OPENSSL_PATH}/lib -lssl -lcrypto"
./configure -prefix "${ins_dir}" -opensource -confirm-license -release \
 -no-pch -platform ${QT_PLATFORM} -no-icu -openssl-linked \
 -nomake examples -nomake tests \
 -skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcanvas3d \
 -skip qtconnectivity -skip qtdeclarative -skip qtdoc -skip qtdocgallery \
 -skip qtenginio -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects \
 -skip qtimageformats -skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtpim \
 -skip qtpurchasing -skip qtquick1 -skip qtquickcontrols -skip qtquickcontrols2 \
 -skip qtrepotools -skip script -skip qtsensors -skip qtserialbus -skip qtserialport \
 -skip qtsvg -skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebkit \
 -skip qtwebkit-examples -skip qtx11extras -skip qtxmlpatterns \
 && make -j 9 &&
make -j1 install

rm -fr ${ins_dir}/doc
rm -fr ${ins_dir}/examples
cd ..
