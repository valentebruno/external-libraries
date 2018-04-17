#!/bin/bash -e
# SDL2
# ====
src_dir=$1
ins_dir=$2
src_dir_absolute=${BUILD_DIR}/${src_dir}
cd ${src_dir_absolute}

if [[ ${BUILD_ARCH} == x64 ]]; then
	_abi=arm64-v8a
else
	_abi=armeabi-v7a
fi

sed 's/+= \($(LOCAL_PATH)\/.*\)/+= $(subst $(LOCAL_PATH)\/,, \1)/g' -i Android.mk
cat <<EOF > android-project/jni/Application.mk
APP_ABI := ${_abi}
EOF

cd android-project/jni
if [[ ! -e SDL ]]; then
	ln -s ../.. SDL
fi
cd .. 

NDK_TOOLCHAIN=${HOST}-clang ${NDK_ROOT}/build/ndk-build V=1 SDL2_static 

if [[ ! -f obj/local/${_abi}/libSDL2.a ]]; then
	exit -1
fi

mkdir ${ins_dir}
mkdir ${ins_dir}/lib
cp obj/local/${_abi}/libSDL2.a ${ins_dir}/lib
mkdir ${ins_dir}/include
mkdir ${ins_dir}/include/SDL2
cp ../include/* ${ins_dir}/include/SDL2