# libuvc
# ======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build
CXXFLAGS="-stdlib=libc++" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release \
-DCMAKE_INSTALL_PREFIX:PATH="${ins_dir}" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" \
-DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10 -DCMAKE_OSX_SYSROOT:PATH=macosx10.12 \
-DLIBUSB_DIR="${LIBUSB_PATH}"
make && make install
