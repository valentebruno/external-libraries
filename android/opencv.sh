#!/bin/bash -e
# OpenCV
# ======n

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

mkdir -p build
cd build

if [[ ${BUILD_ARCH} == x64 ]]; then
  abi=arm64-v8a
else
  abi=armeabi-v7a
fi

cmake -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE} \
  -DCMAKE_INSTALL_PREFIX=${ins_dir} \
  -DANDROID_STANDALONE_TOOLCHAIN=${NDK_TOOLCHAIN} \
  -DBUILD_WITH_STANDALONE_TOOLCHAIN=ON \
  -DANDROID=1 \
  -DANDROID_ABI=${abi} \
  -DANDROID_STL=c++_static \
  -DANDROID_NATIVE_API_LEVEL=21 \
  -DANDROID_SDK_TARGET=21 \
  -DANDROID_SDK_TARGETS=21 \
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
  -DANDROID_NDK_ABI_NAME=${abi} \
  -DZLIB_ROOT=${ZLIB_PATH} \
  ..
make && make install
