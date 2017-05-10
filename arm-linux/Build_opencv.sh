# OpenCV
# ======n

export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DZLIB_ROOT=\"${ZLIB_PATH}\" -DWITH_TBB:BOOL=OFF"

source posix/$(basename $0)
