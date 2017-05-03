#TODO: use the NDK directly using the build/cmake/toolchain.android.cmake file
set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_ANDROID_STANDALONE_TOOLCHAIN $ENV{NDK_TOOLCHAIN})

#These should be autodetected in future versions of cmake
set(CMAKE_ANDROID_API 21)
set(CMAKE_ANDROID_ARCH_ABI arm64-v8a)
set(CMAKE_ANDROID_STL_TYPE c++_static)
add_definitions(-DANDROID) #expected to be set by the toolchain in many cases

#set(CMAKE_ANDROID_NDK $ENV{NDK_ROOT})
#set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION clang)

#set(CMAKE_SYSROOT ${CMAKE_ANDROID_STANDALONE_TOOLCHAIN}/sysroot)
