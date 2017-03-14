#!/bin/sh
# Build and install all of the Leap dependent libraries

#EXTERNAL_LIBRARY_DIR=/opt/local
EXTERNAL_LIBRARY_DIR=${PWD}

EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}/Libraries-arm64-TX1-alt

TOOLCHAIN_FILE=${PWD}/toolchain-arm64-TX1.cmake
export LD_LIBRARY_PATH=/opt/sysroot/TX1-alt/usr/x86_64-linux-gnu/aarch64-linux-gnu/lib

CROSS_COMPILER_PREFIX=/opt/sysroot/TX1-alt/usr/bin/aarch64-linux-gnu-

# assimp
# ======

ASSIMP_VERSION="3.2"
if [ ! -f assimp-${ASSIMP_VERSION}.tar.gz ]; then
  curl -L -o assimp-${ASSIMP_VERSION}.tar.gz https://github.com/assimp/assimp/archive/v${ASSIMP_VERSION}.tar.gz
fi
rm -fr assimp-${ASSIMP_VERSION}
tar xfz assimp-${ASSIMP_VERSION}.tar.gz
cd assimp-${ASSIMP_VERSION}
mkdir build
cd build
CXXFLAGS="-fvisibility=hidden -fPIC -O3 --sysroot=/opt/sysroot/TX1-alt" CFLAGS="-O3 ${ARCH_FLAGS} -fPIC --sysroot=/opt/sysroot/TX1-alt" cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/assimp-${ASSIMP_VERSION}" -DCMAKE_BUILD_TYPE:STRING=Release -DASSIMP_BUILD_TESTS=OFF -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
make -j 9 && make install
cd ../..


# nanosvg
# =======

rm -fr nanosvg
git clone https://github.com/memononen/nanosvg
cd nanosvg
mkdir -p ${EXTERNAL_LIBRARY_DIR}/nanosvg/include
cp src/*.h ${EXTERNAL_LIBRARY_DIR}/nanosvg/include/
cp LICENSE.txt ${EXTERNAL_LIBRARY_DIR}/nanosvg/
cd ..
#!/bin/sh
# Build and install all of the Leap dependent libraries

# polypartition
# =============

rm -fr polypartition
git clone https://github.com/ivanfratric/polypartition.git
cd polypartition
patch -p0 <<"POLYPARTITION_FIX_FAILURE"
--- src/polypartition.cpp
+++ src/polypartition.cpp
@@ -373,7 +373,7 @@
 int TPPLPartition::Triangulate_EC(TPPLPoly *poly, list<TPPLPoly> *triangles) {
 	long numvertices;
 	PartitionVertex *vertices;
-	PartitionVertex *ear;
+	PartitionVertex *ear = nullptr;
 	TPPLPoly triangle;
 	long i,j;
 	bool earfound;
@@ -415,8 +415,7 @@
 			}
 		}
 		if(!earfound) {
-			delete [] vertices;
-			return 0;
+			break; // Something is better than nothing, so go with what we have
 		}
 
 		triangle.Triangle(ear->previous->p,ear->p,ear->next->p);
@@ -458,7 +457,7 @@
 int TPPLPartition::ConvexPartition_HM(TPPLPoly *poly, list<TPPLPoly> *parts) {
 	list<TPPLPoly> triangles;
 	list<TPPLPoly>::iterator iter1,iter2;
-	TPPLPoly *poly1,*poly2;
+	TPPLPoly *poly1 = nullptr,*poly2 = nullptr;
 	TPPLPoly newpoly;
 	TPPLPoint d1,d2,p1,p2,p3;
 	long i11,i12,i21,i22,i13,i23,j,k;
POLYPARTITION_FIX_FAILURE
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/include
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/src
mkdir -p ${EXTERNAL_LIBRARY_DIR}/polypartition/lib
cp src/*.h ${EXTERNAL_LIBRARY_DIR}/polypartition/include/
cp src/*.cpp ${EXTERNAL_LIBRARY_DIR}/polypartition/src/
cd src
for source in *.cpp; do
  ${CROSS_COMPILER_PREFIX}g++ -O3 -std=c++11 -fPIC -fvisibility=hidden ${ARCH_FLAGS} --sysroot=/opt/sysroot/TX1-alt -c ${source}
done
ar cq libpolypartition.a *.o
ranlib libpolypartition.a
cp libpolypartition.a ${EXTERNAL_LIBRARY_DIR}/polypartition/lib/
cd ../..

