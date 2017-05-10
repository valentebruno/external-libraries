# Qt5 [libc++]
# ============

export qt_additional_args="-platform macx-clang -sdk macosx10.12 -no-openssl -securetransport -no-framework"

source posix/$(basename $0)
