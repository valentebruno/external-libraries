#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local
#EXTERNAL_LIBRARY_DIR=${PWD}

if [ "$1" = "32" ]; then
  # if explicitly specified on a 64-bit machine, use another dir
  EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}/Libraries-x86
  ARCH_FLAGS="-m32"
else
  ARCH_FLAGS=""
  EXTERNAL_LIBRARY_DIR=${EXTERNAL_LIBRARY_DIR}/Libraries-x64
fi

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
CXXFLAGS="-fvisibility=hidden -fPIC -O3 ${ARCH_FLAGS}" CFLAGS="-O3 ${ARCH_FLAGS}" LDFLAGS="-L/usr/lib32 -L/usr/lib/i386-linux-gnu" cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/assimp-${ASSIMP_VERSION}" -DCMAKE_BUILD_TYPE:STRING=Release -DASSIMP_BUILD_TESTS=OFF
make -j 9 && make install
cd ../..

# Freetype
# ========

FREETYPE_VERSION="2.6.3"
if [ ! -f freetype-${FREETYPE_VERSION}.tar.bz2 ]; then
  curl -L -O "http://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.bz2"
fi
rm -fr "freetype-${FREETYPE_VERSION}"
tar xfj "freetype-${FREETYPE_VERSION}.tar.bz2"
cd "freetype-${FREETYPE_VERSION}"
sed -e "/AUX.*.gxvalid/s@^# @@" \
    -e "/AUX.*.otvalid/s@^# @@" \
    -i modules.cfg              &&

sed -r -e 's:.*(#.*SUBPIXEL.*) .*:\1:' \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix="${EXTERNAL_LIBRARY_DIR}/Freetype-${FREETYPE_VERSION}" --without-zlib --without-bzip2 --without-png CFLAGS="-O3 -fPIC -fvisibility=hidden ${ARCH_FLAGS}" &&
make -j 9 && make install
cp docs/FTL.TXT "${EXTERNAL_LIBRARY_DIR}/Freetype-${FREETYPE_VERSION}"/
cd ..

# Freetype-gl
# ===========

if [ ! -d freetype-gl ]; then
  git clone https://github.com/rougier/freetype-gl.git
fi
cd freetype-gl
git clean -dfx
git fetch
git reset --hard origin/HEAD
mkdir build
cd build
CFLAGS="-fvisibility=hidden -fPIC -O3 ${ARCH_FLAGS}" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DFREETYPE_INCLUDE_DIRS="${EXTERNAL_LIBRARY_DIR}/freetype-2.6.3/include/freetype2" -DFREETYPE_LIBRARY="${EXTERNAL_LIBRARY_DIR}/freetype-2.6.3/lib/libfreetype.a" -Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF -Dfreetype-gl_BUILD_MAKEFONT=OFF -DGLEW_INCLUDE_PATH="${EXTERNAL_LIBRARY_DIR}/glew-1.9.0/include" -DGLEW_LIBRARY="${EXTERNAL_LIBRARY_DIR}/glew-1.9.0/lib64/libGLEW.a"
make -j 9
mkdir -p "${EXTERNAL_LIBRARY_DIR}/Freetype-gl/include" 
mkdir -p "${EXTERNAL_LIBRARY_DIR}/Freetype-gl/lib" 
cp libfreetype-gl.a "${EXTERNAL_LIBRARY_DIR}/Freetype-gl/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${EXTERNAL_LIBRARY_DIR}/Freetype-gl/include/"
cd ..

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
  g++ -O3 -std=c++11 -fvisibility=hidden ${ARCH_FLAGS} -c ${source}
done
ar cq libpolypartition.a *.o
ranlib libpolypartition.a
cp libpolypartition.a ${EXTERNAL_LIBRARY_DIR}/polypartition/lib/
cd ../..
