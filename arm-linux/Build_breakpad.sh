
# Breakpad [libc++]
# =================


src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd src/third_party
git clone https://chromium.googlesource.com/linux-syscall-support lss --depth 1 --recursive --branch master
cd ../..

if [ "${BUILD_ARCH}" = "x86" ]; then
  BREAKPAD_fLAGS="--enable-m32"
fi

./configure CXXFLAGS="-v -I /usr/include/arm-inux-gnueabihf" --host=arm-linux --prefix="${ins_dir}" ${BREAKPAD_FLAGS}
make && make install
BREAKPAD_INCLUDE="${ins_dir}/include"
cd src
for f in $(find client common google_breakpad processor testing third_party -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
