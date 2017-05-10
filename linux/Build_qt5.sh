# Qt5
# ============

if [ "${BUILD_ARCH}" == "x64" ]; then
  QT_PLATFORM=linux-g++-64
  QT_PLUGIN_DIR=/usr/lib/x86_64-linux-gnu/qt5/plugins
  QT_DBUS="-dbus"
else
  QT_PLATFORM=linux-g++-32
  QT_PLUGIN_DIR=/usr/lib/i386-linux-gnu/qt5/plugins
  QT_DBUS=
fi

export qt_additional_args="-platform ${QT_PLATFORM} -openssl-linked -I${OPENSSL_PATH}/include -verbose"
export OPENSSL_LIBS="-L${OPENSSL_PATH}/lib -lssl -lcrypto -ldl"
source posix/$(basename $0)
