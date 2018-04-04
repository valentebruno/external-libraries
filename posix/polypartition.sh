#!/bin/bash -e
# polypartition
# =============

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

mkdir -p ${ins_dir}/include
mkdir -p ${ins_dir}/src
mkdir -p ${ins_dir}/lib
cp src/*.h ${ins_dir}/include/
cp src/*.cpp ${ins_dir}/src/
cd src
for source in *.cpp; do
  ${CXX} ${CFLAGS} ${CXXFLAGS} -c ${source}
done
ar cq libpolypartition.a *.o
ranlib libpolypartition.a
cp libpolypartition.a ${ins_dir}/lib/
cd ../..
