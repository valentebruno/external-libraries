# libuvc
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" \
-DLIBUSB_DIR="${LIBUSB_PATH}" -DCMAKE_C_FLAGS="-fPIC -O3"
make && make install
cd ..
rm -fr build
