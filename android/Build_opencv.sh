# OpenCV
# ======n

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p build
cd build

cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
  -DCMAKE_INSTALL_PREFIX=${ins_dir} \
  -DANDROID=1 \
  -DANDROID_STANDALONE_TOOLCHAIN=$ENV{NDK_TOOLCHAIN} \
  -DOPENCV_FP16_DISABLE=ON \
  -DBUILD_opencv_apps=OFF \
  -DBUILD_opencv_calib3d=OFF \
  -DBUILD_opencv_core=ON \
  -DBUILD_opencv_features2d=ON \
  -DBUILD_opencv_flann=ON \
  -DBUILD_opencv_highgui=ON \
  -DBUILD_opencv_imgcodecs=OFF \
  -DBUILD_opencv_imgproc=ON \
  -DBUILD_opencv_ml=ON \
  -DBUILD_opencv_objdetect=OFF \
  -DBUILD_opencv_photo=OFF \
  -DBUILD_opencv_shape=OFF \
  -DBUILD_opencv_stitching=OFF \
  -DBUILD_opencv_superres=OFF \
  -DBUILD_opencv_ts=OFF \
  -DBUILD_opencv_video=OFF \
  -DBUILD_opencv_videoio=OFF \
  -DBUILD_opencv_videostab=OFF \
  -DBUILD_opencv_world=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_CUFFT=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_ANDROID_EXAMPLES=OFF \
  -DANDROID_NDK_ABI_NAME=arm64-v8a \
  ..
make && make install
