
# Breakpad
# =================

export CXXFLAGS="${CXXFLAGS} -include endian.h"
export BREAKPAD_FLAGS="--host=${HOST}"

#remove patch for older NDK version
rm "src/$1/src/common/android/include/sys/user.h"

source posix/$(basename $0)
