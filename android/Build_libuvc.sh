# libuvc
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" \
-DLIBUSB_DIR="${LIBUSB_PATH}"
cmake --build . --target install --config Release -- -j8
