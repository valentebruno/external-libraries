#!/bin/bash -e
# Breakpad
# =================

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

if [[ ! -d "src/third_party/lss" ]]; then 
  cd src/third_party
  git clone https://chromium.googlesource.com/linux-syscall-support lss --depth 1 --recursive --branch master
  cd ../..
fi

if [ "${BUILD_ARCH}" = "x86" ]; then
  BREAKPAD_fLAGS="${BREAKPAD_FLAGS} --enable-m32"
fi

./configure --prefix="${ins_dir}" ${BREAKPAD_FLAGS}
make_check_err -j4 && make_check_err install

BREAKPAD_INCLUDE="${ins_dir}/include"
cd src
for f in $(find client common google_breakpad processor testing third_party -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
