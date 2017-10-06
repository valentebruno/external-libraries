#!/bin/bash -e
# OpenCV
# ======n

src_dir=$1
ins_dir=$2
cd src/${src_dir}

if [ ! -f cmake/OpenCVCompilerOptions.cmake.orig ]; then
patch -b -p0 <<"FIX_CMAKE_CCACHE_LOOKUP"
--- cmake/OpenCVCompilerOptions.cmake.orig	2017-09-29 14:53:55.000000000 -0700
+++ cmake/OpenCVCompilerOptions.cmake	2017-09-29 14:53:57.000000000 -0700
@@ -18,9 +18,9 @@
         message(STATUS "Unable to compile program with enabled ccache, reverting...")
         set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${__OLD_RULE_LAUNCH_COMPILE}")
       endif()
-    else()
-      message(STATUS "Looking for ccache - not found")
     endif()
+  else()
+    message(STATUS "Looking for ccache - not found")
   endif()
 endif()
FIX_CMAKE_CCACHE_LOOKUP
fi

build_cmake_lib "${ins_dir}" -DBUILD_DOCS:BOOL=OFF \
-DBUILD_PERF_TESTS:BOOL=OFF \
-DBUILD_TESTS:BOOL=OFF \
-DEIGEN_INCLUDE_PATH:PATH="${EIGEN_PATH}" \
-DWITH_CUDA:BOOL=OFF \
-DWITH_MATLAB:BOOL=OFF \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DWITH_QT:BOOL=OFF \
-DWITH_CUFFT:BOOL=OFF \
-DWITH_TIFF:BOOL=OFF \
-DWITH_OPENCL:BOOL=OFF \
-DWITH_MATLAB:BOOL=OFF \
-DWITH_WEBP:BOOL=OFF \
-DWITH_OPENCL:BOOL=OFF \
-DBUILD_opencv_cudaarithm:BOOL=OFF \
-DBUILD_opencv_cudabgsegm:BOOL=OFF \
-DBUILD_opencv_cudacodec:BOOL=OFF \
-DBUILD_opencv_cudafeatures2d:BOOL=OFF \
-DBUILD_opencv_cudafilters:BOOL=OFF \
-DBUILD_opencv_cudaimgproc:BOOL=OFF \
-DBUILD_opencv_cudalegacy:BOOL=OFF \
-DBUILD_opencv_cudaobjdetect:BOOL=OFF \
-DBUILD_opencv_cudaoptflow:BOOL=OFF \
-DBUILD_opencv_cudastereo:BOOL=OFF \
-DBUILD_opencv_cudawarping:BOOL=OFF \
-DBUILD_opencv_cudev:BOOL=OFF
