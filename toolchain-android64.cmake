#TODO: use the NDK directly using the build/cmake/toolchain.android.cmake file
set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_ANDROID_STANDALONE_TOOLCHAIN $ENV{NDK_TOOLCHAIN})

string(APPEND CMAKE_CXX_STANDARD_LIBRARIES " -static-libstdc++ -latomic")

#These should be autodetected in future versions of cmake (or may not be required at all)
set(CMAKE_ANDROID_API 21)
set(CMAKE_ANDROID_ARCH_ABI arm64-v8a)

add_definitions(-DANDROID) #expected to be set by the toolchain in many cases
set(CMAKE_FIND_ROOT_PATH "$ENV{EXT_LIB_INSTALL_ROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
