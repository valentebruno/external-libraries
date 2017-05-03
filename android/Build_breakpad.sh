
# Breakpad
# =================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd src/third_party
git clone https://chromium.googlesource.com/linux-syscall-support lss --depth 1 --recursive --branch master
cd ../..

./configure CXXFLAGS="-v -include endian.h" --host=${HOST} --prefix="${ins_dir}"

#remove patch for older NDK version
rm "src/common/android/include/sys/user.h"

make -j4 VERBOSE=1 && make install
BREAKPAD_INCLUDE="${ins_dir}/include"

cd src
for f in $(find client common google_breakpad processor testing third_party -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
