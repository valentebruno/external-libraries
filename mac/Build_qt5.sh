# Qt5 [libc++]
# ============

src_dir=$1
ins_dir=$2
cd src/${src_dir}

./configure -prefix "${ins_dir}" -opensource -confirm-license -release \
 -no-pch -platform macx-clang -no-openssl -securetransport -no-icu \
 -no-framework -nomake examples -nomake tests \
 -skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcanvas3d \
 -skip qtconnectivity -skip qtdeclarative -skip qtdoc -skip qtdocgallery \
 -skip qtenginio -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects \
 -skip qtimageformats -skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtpim \
 -skip qtpurchasing -skip qtquick1 -skip qtquickcontrols -skip qtquickcontrols2 \
 -skip qtrepotools -skip script -skip qtsensors -skip qtserialbus -skip qtserialport \
 -skip qtsvg -skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebkit \
 -skip qtwebkit-examples -skip qtx11extras -skip qtxmlpatterns \
 -sdk macosx10.12 && make -j 9
make  -j1 install

rm -fr ${ins_dir}/doc
rm -fr ${ins_dir}/examples
cd ..

