#!/bin/bash
# polypartition
# =============

src_dir=$1
ins_dir=$2
cd src/${src_dir}

patch -w -p0 <<"POLYPARTITION_FIX_FAILURE"
--- src/polypartition.cpp
+++ src/polypartition.cpp
@@ -373,7 +373,7 @@
 int TPPLPartition::Triangulate_EC(TPPLPoly *poly, list<TPPLPoly> *triangles) {
  long numvertices;
  PartitionVertex *vertices;
- PartitionVertex *ear;
+ PartitionVertex *ear = nullptr;
  TPPLPoly triangle;
  long i,j;
  bool earfound;
@@ -415,8 +415,7 @@
      }
    }
    if(!earfound) {
-     delete [] vertices;
-     return 0;
+     break; // Something is better than nothing, so go with what we have
    }

    triangle.Triangle(ear->previous->p,ear->p,ear->next->p);
@@ -458,7 +457,7 @@
 int TPPLPartition::ConvexPartition_HM(TPPLPoly *poly, list<TPPLPoly> *parts) {
  list<TPPLPoly> triangles;
  list<TPPLPoly>::iterator iter1,iter2;
- TPPLPoly *poly1,*poly2;
+ TPPLPoly *poly1 = nullptr,*poly2 = nullptr;
  TPPLPoly newpoly;
  TPPLPoint d1,d2,p1,p2,p3;
  long i11,i12,i21,i22,i13,i23,j,k;
POLYPARTITION_FIX_FAILURE
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
