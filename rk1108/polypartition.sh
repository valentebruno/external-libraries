#!/bin/sh
# Build and install all of the Leap dependent libraries

CUR_DIR=${PWD}
CROSS_COMPILER_PREFIX=arm-linux-
TOOLCHAIN_FILE=${CUR_DIR}/toolchain-rk1108.cmake
EXTERNAL_LIBRARY_DIR=${CUR_DIR}/Libraries-rk1108
RK1108_SYSROOT=/opt/rk1108_toolchain/usr/arm-rkcvr-linux-uclibcgnueabihf/sysroot
HOST_NAME=arm-linux

# polypartition
# =============

rm -fr polypartition
git clone https://github.com/ivanfratric/polypartition.git
cd polypartition
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/include
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/src
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/lib
cp src/*.h ${EXTERNAL_LIBRARY_DIR}/polypartition/include/
cp src/*.cpp ${EXTERNAL_LIBRARY_DIR}/polypartition/src/
cd src
for source in *.cpp; do
  ${CROSS_COMPILER_PREFIX}g++ -O3 -std=c++11 -fPIC -fvisibility=hidden ${ARCH_FLAGS} -c ${source}
done
${CROSS_COMPILER_PREFIX}ar cq libpolypartition.a *.o
${CROSS_COMPILER_PREFIX}ranlib libpolypartition.a
cp libpolypartition.a ${EXTERNAL_LIBRARY_DIR}/polypartition/lib/
cd ../..
