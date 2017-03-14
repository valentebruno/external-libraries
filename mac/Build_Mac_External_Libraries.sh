#!/bin/sh
# Build and install all of the Leap dependent libraries

EXTERNAL_LIBRARY_DIR=/opt/local/Libraries

# libusb
# ======

LIBUSB_ORIGIN="git@github.com:leapmotion/libusb.git"
rm -fr libusb
git clone --branch leap-2.2.x "${LIBUSB_ORIGIN}"
cd libusb
./bootstrap.sh
./configure --disable-log CC=clang CFLAGS="-O3 -mmacosx-version-min=10.7 -arch x86_64 -arch i386"
make
install_name_tool -id @loader_path/libusb-1.0.0.dylib libusb/.libs/libusb-1.0.0.dylib
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb
mkdir -p ${EXTERNAL_LIBRARY_DIR}/libusb/lib
cp libusb/libusb.h ${EXTERNAL_LIBRARY_DIR}/libusb/include/libusb/
cp libusb/.libs/libusb-1.0.0.dylib ${EXTERNAL_LIBRARY_DIR}/libusb/lib/
cd ..

# libuvc
# ======

rm -fr libuvc
git clone git@sf-github.leap.corp:leapmotion/libuvc.git
cd libuvc
mkdir -p Build
cd Build
CXXFLAGS="-stdlib=libc++" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/libuvc" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.7 -DCMAKE_OSX_SYSROOT:PATH=macosx10.9 -DLIBUSB_DIR="${EXTERNAL_LIBRARY_DIR}/libusb"
make && make install
cd ..
rm -fr Build
cd ..

# bzip2
# =====

BZIP2_VERSION="1.0.6"
if [ ! -f bzip-${BZIP2_VERSION}.tar.gz ]; then
  curl -sLO http://www.bzip.org/${BZIP2_VERSION}/bzip2-${BZIP2_VERSION}.tar.gz
fi
rm -fr bzip2-${BZIP2_VERSION}
tar xfz bzip2-${BZIP2_VERSION}.tar.gz
cd bzip2-${BZIP2_VERSION}
patch -p0 <<"MAKEFILE_OPTIONS"
--- Makefile    2016-07-07 11:53:54.000000000 -0700
+++ Makefile    2016-07-07 11:54:34.000000000 -0700
@@ -21,7 +21,7 @@
 LDFLAGS=
 
 BIGFILES=-D_FILE_OFFSET_BITS=64
-CFLAGS=-Wall -Winline -O2 -g $(BIGFILES)
+CFLAGS=-Wall -Winline $(BIGFILES) -mmacosx-version-min=10.7 -O3 -arch x86_64 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden
 
 # Where you want it installed when you do 'make install'
 PREFIX=/usr/local
MAKEFILE_OPTIONS
make -j 4 && make install PREFIX="${EXTERNAL_LIBRARY_DIR}/bzip2-${BZIP2_VERSION}"
cd ..

# zlib
# ====

ZLIB_VERSION="1.2.8"
if [ ! -f zlib-${ZLIB_VERSION}.tar.gz ]; then
  curl -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
fi
rm -fr zlib-${ZLIB_VERSION}
tar xfj zlib-${ZLIB_VERSION}.tar.gz
cd zlib-${ZLIB_VERSION}
CC=clang CFLAGS="-mmacosx-version-min=10.7 -O3 -arch x86_64 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}" --static
make -j 4 && make install
cd ..

# Crossroads (libxs) [libc++]
# ===========================

XS_VERSION="1.2.0"
rm -fr libxs
git clone --depth 1 --branch leap https://github.com/leapmotion/libxs.git
cd libxs
./autogen.sh
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/libxs-${XS_VERSION}-libc++" --enable-static --disable-shared CXX=clang++ CXXFLAGS="-O2 -DLIBCXX_WORKAROUND=1 -D_THREAD_SAFE -mmacosx-version-min=10.7 -arch x86_64 -arch i386 -std=c++11 -stdlib=libc++"
make && make install
cd ..

# Protocol Buffers (protobuf) [libc++]
# ====================================

PROTOBUF_VERSION="2.5.0"
if [ ! -f protobuf-${PROTOBUF_VERSION}.tar.bz2 ]; then
  curl -O http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VERSION}.tar.bz2
fi
rm -fr protobuf-${PROTOBUF_VERSION}
tar xfj protobuf-${PROTOBUF_VERSION}.tar.bz2
cd protobuf-${PROTOBUF_VERSION}
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}-libc++" --enable-static --disable-shared --with-zlib CXX=clang++ CXXFLAGS="-O3 -D_THREAD_SAFE -mmacosx-version-min=10.7 -arch x86_64 -arch i386 -stdlib=libc++ -fvisibility=hidden -fvisibility-inlines-hidden" CPPFLAGS="-I${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/include" LDFLAGS="-L${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/lib"
make -j 4 && make install
# The build system looks in the src directory for include files. Make a link for now.
(cd "${EXTERNAL_LIBRARY_DIR}/protobuf-${PROTOBUF_VERSION}-libc++"; ln -s include src)
cd ..

# OpenSSL
# =======

OPENSSL_VERSION="1.0.0j"
if [ ! -f openssl-${OPENSSL_VERSION}.tar.gz ]; then
  curl -O http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
fi
rm -fr openssl-${OPENSSL_VERSION}
tar xfz openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
./Configure --prefix="${EXTERNAL_LIBRARY_DIR}/openssl" no-asm darwin-i386-cc
make
mkdir -p i386
mv apps/openssl libcrypto.a libssl.a i386/
make clean
./Configure --prefix="${EXTERNAL_LIBRARY_DIR}/openssl" darwin64-x86_64-cc
make
mkdir -p x86_64
mv apps/openssl libcrypto.a libssl.a x86_64/
lipo -create x86_64/openssl i386/openssl -output apps/openssl
lipo -create x86_64/libcrypto.a i386/libcrypto.a -output libcrypto.a
lipo -create x86_64/libssl.a i386/libssl.a -output libssl.a
make install
cd ..

# cURL
# ====

CURL_VERSION="7.36.0"
if [ ! -f "curl-${CURL_VERSION}.tar.bz2" ]l then
  curl -O "http://curl.haxx.se/download/curl-${CURL_VERSION}.tar.bz2"
fi
rm -fr curl-${CURL_VERSION}
tar xfj "curl-${CURL_VERSION}.tar.bz2"
cd "curl-${CURL_VERSION}"
CC=clang CFLAGS="-arch i386" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/curl-${CURL_VERSION}" --with-zlib="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/" --with-ssl="${EXTERNAL_LIBRARY_DIR}/openssl/" --without-ca-path --without-ca-bundle --without-libidn --disable-dict --disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http --enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps --disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps --disable-telnet --disable-tftp --disable-shared --enable-optimize --disable-debug --enable-symbol-hiding
mkdir -p universal
echo "#if __i386__" > universal/curlbuild.h
cat include/curl/curlbuild.h >> universal/curlbuild.h
make -j 4
mv lib/.libs/libcurl.a universal/libcurl.i386.a
mv src/curl universal/curl.i386
make distclean
CC=clang CFLAGS="-arch x86_64" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/curl-${CURL_VERSION}" --with-zlib="${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/" --with-ssl="${EXTERNAL_LIBRARY_DIR}/openssl/" --without-ca-path --without-ca-bundle --without-libidn --disable-dict --disable-file --disable-ftp --disable-ftps --disable-gopher --enable-http --enable-https --disable-imap --disable-imaps --disable-ldap --disable-ldaps --disable-pop3 --disable-pop3s --disable-rtsp --disable-smtp --disable-smtps --disable-telnet --disable-tftp --disable-shared --enable-optimize --disable-debug --enable-symbol-hiding
echo "#elif __x86_64__" >> universal/curlbuild.h
cat include/curl/curlbuild.h >> universal/curlbuild.h
echo "#else" >> universal/curlbuild.h
echo "#error Unsupported Architecture" >> universal/curlbuild.h
echo "#endif" >> universal/curlbuild.h
make -j 4
mv lib/.libs/libcurl.a universal/libcurl.x86_64.a
mv src/curl universal/curl.x86_64
mv universal/curlbuild.h include/curl/curlbuild.h
lipo -create universal/libcurl.i386.a universal/libcurl.x86_64.a -output lib/.libs/libcurl.a
lipo -create universal/curl.i386 universal/curl.x86_64 -output src/curl
make install
cd ..

# Eigen
# =====

EIGEN_VERSION="3.3.1"
EIGEN_HASH="f562a193118d"
if [ ! -f ${EIGEN_VERSION}.tar.bz2 ]; then
  curl -O https://bitbucket.org/eigen/eigen/get/${EIGEN_VERSION}.tar.bz2
fi
rm -fr eigen-eigen-${EIGEN_HASH}
tar xfj ${EIGEN_VERSION}.tar.bz2
mkdir -p "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported"
cp -R eigen-eigen-${EIGEN_HASH}/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/"
cp -R eigen-eigen-${EIGEN_HASH}/unsupported/Eigen "${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}/unsupported/"

# JDK
# ===

mkdir -p "${EXTERNAL_LIBRARY_DIR}/jdk/include"
cp -R /System/Library/Frameworks/JavaVM.framework/Versions/A/Headers/* "${EXTERNAL_LIBRARY_DIR}/jdk/include/"

# Qt5 [libc++]
# ============

QT_VERSION_PARTIAL="5.5"
QT_VERSION="${QT_VERSION_PARTIAL}.0"
if [ ! -f qt-everywhere-opensource-src-${QT_VERSION}.tar.gz ]; then
  curl -L -O http://download.qt.io/official_releases/qt/${QT_VERSION_PARTIAL}/${QT_VERSION}/single/qt-everywhere-opensource-src-${QT_VERSION}.tar.gz
fi
rm -fr qt-everywhere-opensource-src-${QT_VERSION}
tar xfz qt-everywhere-opensource-src-${QT_VERSION}.tar.gz
cd qt-everywhere-opensource-src-${QT_VERSION}
./configure --prefix="${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}" -opensource -confirm-license -release -no-pch -c++11 -platform macx-clang -openssl-linked -I "${EXTERNAL_LIBRARY_DIR}/openssl/include" -L "${EXTERNAL_LIBRARY_DIR}/openssl/lib" -no-framework -no-xcb -no-ssse3 -no-sse4.1 -no-sse4.2 -no-avx -no-avx2 -sdk macosx10.9 && make -j 9 && make install
# TODO: Use -noopenssl -securetransport instead of OpenSSL once OS X 10.7 support is deprecated
# ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}" -opensource -confirm-license -release -no-pch -c++11 -platform macx-clang -no-openssl -securetransport -no-framework -no-xcb -no-ssse3 -no-sse4.1 -no-sse4.2 -no-avx -no-avx2 -sdk macosx10.9 && make -j 9 && make install
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/doc
rm -fr ${EXTERNAL_LIBRARY_DIR}/qt-${QT_VERSION}/examples
cd ..

# OpenCV
# ======

OPENCV_VERSION="3.2.0"
if [ ! -f OpenCV-${OPENCV_VERSION}.zip ]; then
  curl -Lo OpenCV-${OPENCV_VERSION}.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
fi
rm -fr OpenCV-${OPENCV_VERSION}
unzip -x OpenCV-${OPENCV_VERSION}.zip
cd opencv-${OPENCV_VERSION}
mkdir -p Build
cd Build
CC="clang" cmake .. -DBUILD_DOCS:BOOL=OFF -DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/OpenCV-${OPENCV_VERSION}" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.9 -DCMAKE_OSX_SYSROOT:PATH=macosx10.12 -DEIGEN_INCLUDE_PATH:PATH="${EXTERNAL_LIBRARY_DIR}/eigen-${EIGEN_VERSION}" -DWITH_CUDA:BOOL=OFF -DWITH_QT:BOOL=OFF -DWITH_WEBP:BOOL=OFF -DWITH_OPENCL:BOOL=OFF -DWITH_MATLAB:BOOL=OFF -DENABLE_SSE41:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=OFF
make && make install
cd ..
rm -fr Build
cd ..

# bullet
# ======

BULLET_VERSION="2.84"
git clone git@github.com:bulletphysics/bullet3.git bullet-${BULLET_VERSION}
cd bullet-${BULLET_VERSION}
git fetch
git checkout df3ddaca5eb
git clean -df
CC=clang CXXFLAGS="-fvisibility=hidden -fvisibility-inlines-hidden" cmake -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING="10.7" -DCMAKE_OSX_SYSROOT:PATH=macosx10.11 -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/bullet-${BULLET_VERSION}" -DBUILD_DEMOS:BOOL=OFF -DBUILD_BULLET2_DEMOS:BOOL=OFF -DBUILD_BULLET3:BOOL=OFF -DBUILD_CPU_DEMOS:BOOL=OFF -DBUILD_EXTRAS:BOOL=OFF -DBUILD_OPENGL3_DEMOS:BOOL=OFF -DBUILD_UNIT_TESTS:BOOL=OFF
make -j 4 && make install
cd ..

# glew
# ====

GLEW_VERSION="1.9.0"
if [ ! -f glew-${GLEW_VERSION}.tgz ]; then
  curl -O http://iweb.dl.sourceforge.net/project/glew/glew/${GLEW_VERSION}/glew-${GLEW_VERSION}.tgz
fi
rm -fr glew-${GLEW_VERSION}
tar xfz glew-${GLEW_VERSION}.tgz
cd glew-${GLEW_VERSION}
patch -p0 <<"GLEW_MAC_BUILD_PATCH"
--- Makefile	2012-08-06 08:59:08.000000000 -0700
+++ Makefile	2012-11-08 11:14:50.000000000 -0800
@@ -61,6 +61,8 @@
 #   - use LN= on gmake command-line
 
 AR      ?= ar
+ARFLAGS ?= cr
+RANLIB  ?= ranlib
 INSTALL ?= install
 STRIP   ?= strip
 RM      ?= rm -f
@@ -100,7 +102,7 @@
 	mkdir lib
 
 lib/$(LIB.STATIC): $(LIB.OBJS)
-	$(AR) cr $@ $^
+	$(AR) $(ARFLAGS) $@ $^
 ifneq ($(STRIP),)
 	$(STRIP) -x $@
 endif
@@ -139,7 +141,7 @@
 glew.lib.mx:  lib lib/$(LIB.SHARED.MX) lib/$(LIB.STATIC.MX) glewmx.pc
 
 lib/$(LIB.STATIC.MX): $(LIB.OBJS.MX)
-	$(AR) cr $@ $^
+	$(AR) $(ARFLAGS) $@ $^
 
 lib/$(LIB.SHARED.MX): $(LIB.SOBJS.MX)
 	$(LD) $(LDFLAGS.SO.MX) -o $@ $^ $(LIB.LDFLAGS) $(LIB.LIBS)
--- config/Makefile.darwin	2012-08-06 08:59:08.000000000 -0700
+++ config/Makefile.darwin	2012-11-08 11:18:25.000000000 -0800
@@ -1,10 +1,10 @@
 NAME = $(GLEW_NAME)
 CC = cc
 LD = cc
-CFLAGS.EXTRA = -dynamic -fno-common
+CFLAGS.EXTRA = -arch x86_64 -arch i386 -dynamic -fno-common
 #CFLAGS.EXTRA += -no-cpp-precomp
 PICFLAG = -fPIC
-LDFLAGS.EXTRA =
+LDFLAGS.EXTRA = -arch x86_64 -arch i386
 ifneq (undefined, $(origin GLEW_APPLE_GLX))
 CFLAGS.EXTRA += -I/usr/X11R6/include -D'GLEW_APPLE_GLX'
 LDFLAGS.GL = -L/usr/X11R6/lib -lXmu -lXi -lGL -lXext -lX11
GLEW_MAC_BUILD_PATCH
GLEW_DEST="${EXTERNAL_LIBRARY_DIR}/glew-${GLEW_VERSION}" AR=libtool ARFLAGS=-o make install
cd ..

# AntTweakBar [libc++]
# ====================

rm -fr anttweakbar
git clone --branch sdl20 git@github.com:leapmotion/anttweakbar.git
cd anttweakbar/src
patch -p0 <<"ATB_MAKE_OSX_PATCH"
--- Makefile.osx
+++ Makefile.osx
@@ -4,8 +4,8 @@ SO_EXT		= .dylib
 AR_EXT		= .a
 
 #---- Release
-CXXCFG   	= -O3
-LFLAGS		= 
+CXXCFG   	= -O3 -arch i386 -arch x86_64 -stdlib=libc++ -mmacosx-version-min=10.7
+LFLAGS		= $(CXXCFG)
 OUT_DIR		= ../lib
 #---- Debug
 #CXXCFG   	= -g -D_DEBUG
@@ -13,13 +13,14 @@ OUT_DIR		= ../lib
 #OUT_DIR	= ../lib/debug
 
 #BASE		= /Developer/SDKs/MacOSX10.5.sdk/System/Library/Frameworks
-CXX      	= g++
+CC      	= clang
+CXX      	= clang++
 CXXFLAGS 	= $(CXXCFG) -Wall -fPIC -fno-strict-aliasing -D_MACOSX -ObjC++  -D__PLACEMENT_NEW_INLINE
 INCPATH  	= -I../include -I/usr/local/include -I/usr/X11R6/include -I/usr/include
 #-I$(BASE)/OpenGL.framework/Headers/ -I$(BASE)/GLUT.framework/Headers/ -I$(BASE)/AppKit.framework/Headers/
-LINK     	= g++
+LINK     	= clang++
 LIBS 		= -framework OpenGL -framework GLUT -framework AppKit
-AR       	= ar cqs
+AR       	= libtool -static -o
 RANLIB   	=
 TAR      	= tar -cf
 GZIP     	= gzip -9f
@@ -72,7 +73,7 @@ $(TARGET): $(OBJS)
 
 .c.o:
 	@echo "===== Compile $< ====="
-	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<
+	$(CC) -c $(CXXFLAGS) $(INCPATH) -o $@ $<
 
 clean:
 	@echo "===== Clean ====="
ATB_MAKE_OSX_PATCH
patch -p0 <<"ATB_OPENGL_CONST"
--- LoadOGLCore.h	2014-03-14 09:39:22.000000000 -0700
+++ LoadOGLCore.h	2014-03-14 09:40:26.000000000 -0700
@@ -146,7 +146,7 @@
 // GL 1.4
 ANT_GL_CORE_DECL(void, glBlendFuncSeparate, (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha))
 ANT_GL_CORE_DECL(void, glMultiDrawArrays, (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount))
-ANT_GL_CORE_DECL(void, glMultiDrawElements, (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* *indices, GLsizei primcount))
+ANT_GL_CORE_DECL(void, glMultiDrawElements, (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei primcount))
 ANT_GL_CORE_DECL(void, glPointParameterf, (GLenum pname, GLfloat param))
 ANT_GL_CORE_DECL(void, glPointParameterfv, (GLenum pname, const GLfloat *params))
 ANT_GL_CORE_DECL(void, glPointParameteri, (GLenum pname, GLint param))
@@ -211,7 +211,7 @@
 ANT_GL_CORE_DECL(GLboolean, glIsProgram, (GLuint program))
 ANT_GL_CORE_DECL(GLboolean, glIsShader, (GLuint shader))
 ANT_GL_CORE_DECL(void, glLinkProgram, (GLuint program))
-ANT_GL_CORE_DECL(void, glShaderSource, (GLuint shader, GLsizei count, const GLchar* *string, const GLint *length))
+ANT_GL_CORE_DECL(void, glShaderSource, (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length))
 ANT_GL_CORE_DECL(void, glUseProgram, (GLuint program))
 ANT_GL_CORE_DECL(void, glUniform1f, (GLint location, GLfloat v0))
 ANT_GL_CORE_DECL(void, glUniform2f, (GLint location, GLfloat v0, GLfloat v1))
ATB_OPENGL_CONST
make -j 4 -f Makefile.osx
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar-libc++/include"
mkdir -p "${EXTERNAL_LIBRARY_DIR}/AntTweakBar-libc++/lib"
cp -R ../include/* "${EXTERNAL_LIBRARY_DIR}/AntTweakBar-libc++/include/"
cp ../lib/libAntTweakBar.dylib "${EXTERNAL_LIBRARY_DIR}/AntTweakBar-libc++/lib"
install_name_tool -id @loader_path/libAntTweakBar.dylib "${EXTERNAL_LIBRARY_DIR}/AntTweakBar-libc++/lib/libAntTweakBar.dylib"
cd ../..

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
CXXFLAGS="-stdlib=libc++ -fvisibility=hidden" cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF -DASSIMP_BUILD_STATIC_LIB:BOOL=ON -DCMAKE_INSTALL_PREFIX="${EXTERNAL_LIBRARY_DIR}/assimp-${ASSIMP_VERSION}" -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.7 -DCMAKE_OSX_SYSROOT=macosx10.11 -DASSIMP_BUILD_TESTS=OFF
make -j 9 && make install
cd ../..


# SFML
# ====

SFML_VERSION="2.1"
if [ ! -f SFML-${SFML_VERSION}-sources.zip ]; then
  curl -O http://www.sfml-dev.org/download/sfml/${SFML_VERSION}/SFML-${SFML_VERSION}-sources.zip
fi
rm -fr SFML-${SFML_VERSION}
unzip -x SFML-${SFML_VERSION}-sources.zip
cd SFML-${SFML_VERSION}
patch -p0 <<"SFML_MAC_MEMORY_LEAK"
--- src/SFML/Window/OSX/SFApplication.m
+++ src/SFML/Window/OSX/SFApplication.m
@@ -39,6 +39,7 @@
     [SFApplication sharedApplication]; // Make sure NSApp exists
     NSEvent* event = nil;
     
+    @autoreleasepool {
     while ((event = [NSApp nextEventMatchingMask:NSAnyEventMask
                                        untilDate:[NSDate distantPast]
                                           inMode:NSDefaultRunLoopMode
@@ -46,6 +47,7 @@
     {
         [NSApp sendEvent:event];
     }
+    }
 }
 
 - (void)sendEvent:(NSEvent *)anEvent
SFML_MAC_MEMORY_LEAK
mkdir build
cd build
cmake .. -DCMAKE_CXX_FLAGS:STRING="-stdlib=libc++" -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/SFML-${SFML_VERSION}" -DCMAKE_INSTALL_FRAMEWORK_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/SFML-2.1/Frameworks" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.7 -DCMAKE_OSX_SYSROOT:PATH=macosx10.9
make -j 4 && make install/strip
cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF
make -j 4 && make install/strip && cp ../extlibs/libs-osx/lib/lib*.a "${EXTERNAL_LIBRARY_DIR}/SFML-${SFML_VERSION}/lib/"
cd ..

# SDL2
# ====

SDL2_VERSION="2.0.3"
if [ ! -f SDL2-${SDL2_VERSION}.tar.gz ]; then
  curl -O http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz
fi
rm -fr SDL2-${SDL2_VERSION}
tar xfz SDL2-${SDL2_VERSION}.tar.gz
cd SDL2-${SDL2_VERSION}
CC="clang -arch i386" CFLAGS="-mmacosx-version-min=10.6" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/SDL2-${SDL2_VERSION}" --disable-shared -enable-static --disable-audio --disable-joystick --disable-haptic --host=i386-apple-darwin
make -j 4
mkdir tmp
cp build/.libs/libSDL2.a tmp/libSDL2-i386.a
cp build/libSDL2_test.a tmp/libSDL2_test-i386.a
cp build/libSDL2main.a tmp/libSDL2main-i386.a
cp build/.libs/libSDL2-2.0.0.dylib tmp/libSDL2-2.0.0-i386.dylib
make distclean
CC="clang -arch x86_64" CFLAGS="-mmacosx-version-min=10.6" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/SDL2-${SDL2_VERSION}" --disable-shared --enable-static --disable-audio --disable-joystick --disable-haptic --host=x86_64-apple-darwin
make -j 4
mv build/.libs/libSDL2.a tmp/libSDL2-x86_64.a
mv build/libSDL2_test.a tmp/libSDL2_test-x86_64.a
mv build/libSDL2main.a tmp/libSDL2main-x86_64.a
lipo -create -o build/.libs/libSDL2.a tmp/libSDL2-{x86_64,i386}.a
lipo -create -o build/libSDL2_test.a tmp/libSDL2_test-{x86_64,i386}.a
lipo -create -o build/libSDL2main tmp/libSDL2main-{x86_64,i386}.a
make install
cd ..

# FreeImage
# =========

FREEIMAGE_VERSION="3.16.0"
FREEIMAGE_ZIP=FreeImage${FREEIMAGE_VERSION//./}.zip
if [ ! -f ${FREEIMAGE_ZIP} ]; then
  curl -O http://iweb.dl.sourceforge.net/project/freeimage/Source%20Distribution/${FREEIMAGE_VERSION}/${FREEIMAGE_ZIP}
fi
rm -fr FreeImage
unzip -x ${FREEIMAGE_ZIP}
cd FreeImage
curl -O https://raw.githubusercontent.com/sol-prog/FreeImage-OSX/master/Makefile.osx
sed -i.bak '/^COMPILERFLAGS = / s/$/ -D__ANSI__ -DDISABLE_PERF_MEASUREMENT/' Makefile.osx
sed -i.bak 's/MacOSX10\.8\.sdk/MacOSX10\.9\.sdk/g' Makefile.osx 
sed -i.bak 's:^PREFIX = .*:PREFIX = '${EXTERNAL_LIBRARY_DIR}'/FreeImage:' Makefile.osx
sed -i.bak 's/-o root -g wheel //g' Makefile.osx
sed -i.bak 's/^FreeImage: $(STATICLIB) $(SHAREDLIB)/FreeImage: $(STATICLIB)/' Makefile.osx
sed -i.bak 's/install -m 644 $(SHAREDLIB) /install -m 644 /' Makefile.osx
sed -i.bak '/cp \*\.dylib Dist/d' Makefile.osx
sed -i.bak '/ln -sf $(SHAREDLIB) $(INSTALLDIR)\/$(LIBNAME)/d' Makefile.osx
rm -f Makefile.osx.bak
make -f Makefile.osx -j 4 && make -f Makefile.osx install
cd ..

# nss
# ===

NSS_VERSION=3.16.3
NSS_VERSION_UNDERSCORE=3_16_3
NSPR_VERSION=4.10.6

if [ ! -f nss-${NSS_VERSION}-with-nspr-${NSPR_VERSION}.tar.gz ]; then
  curl -O ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_${NSS_VERSION_UNDERSCORE}_RTM/src/nss-${NSS_VERSION}-with-nspr-${NSPR_VERSION}.tar.gz
fi
rm -fr nss-${NSS_VERSION}
tar xfz nss-${NSS_VERSION}-with-nspr-${NSPR_VERSION}.tar.gz
cd nss-${NSS_VERSION}
cd nss
make nss_build_all BUILD_OPT=1 USE_X32=1
make nss_build_all BUILD_OPT=1 USE_64=1
cd ../dist
NSS_BASE=Darwin`uname -r`
NSS_FAT=${NSS_BASE}_FAT_OPT.OBJ
NSS_X64=${NSS_BASE}_64_OPT.OBJ
NSS_X32=${NSS_BASE}_OPT.OBJ
NSS_INSTALL=${EXTERNAL_LIBRARY_DIR}/nss-${NSS_VERSION}
rm -fr ${NSS_FAT}
mkdir -p ${NSS_FAT}/bin
mkdir -p ${NSS_FAT}/lib
cd ${NSS_X64}/bin
for fn in *; do
  lipo -output ../../${NSS_FAT}/bin/"${fn}" -create -arch x86_64 "${fn}" -arch i386 ../../${NSS_X32}/bin/"${fn}"
done
cd ../lib
for fn in *; do
  lipo -output ../../${NSS_FAT}/lib/"${fn}" -create -arch x86_64 "${fn}" -arch i386 ../../${NSS_X32}/lib/"${fn}"
done
cd ../..
mkdir -p ${NSS_INSTALL}/lib
install -v -m 644 ${NSS_FAT}/lib/*.a ${NSS_INSTALL}/lib
mkdir -p ${NSS_INSTALL}/include/nss
cp -v -RL {public,private}/nss/* ${NSS_INSTALL}/include/nss
cp ${NSS_X64}/include/prcpucfg.h ${NSS_INSTALL}/include/nss
chmod -v 644 ${NSS_INSTALL}/include/nss/*
mkdir -p ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_FAT}/bin/{certutil,pk12util} ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_FAT}/lib/*.{chk,dylib} ${NSS_INSTALL}/bin
cd ../nspr
mkdir -p ${NSS_INSTALL}/include/nspr/obsolete
mkdir -p ${NSS_INSTALL}/include/nspr/private
cp -v -RL pr/include/*.h ${NSS_INSTALL}/include/nspr
cp -v -RL pr/include/obsolete/*.h ${NSS_INSTALL}/include/nspr/obsolete
cp -v -RL pr/include/private/*.h ${NSS_INSTALL}/include/nspr/private
cp -v -RL lib/ds/*.h ${NSS_INSTALL}/include/nspr
cp -v -RL lib/libc/include/*.h ${NSS_INSTALL}/include/nspr
chmod -v 644 ${NSS_INSTALL}/include/nspr/*.h
chmod -v 644 ${NSS_INSTALL}/include/nspr/*/*.h
cd ../..

# LuaJIT
# ======

LUAJIT_VERSION="2.0.1"
if [ ! -f LuaJIT-${LUAJIT_VERSION}.tar.gz ]; then
  curl -O http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
fi
rm -fr LuaJIT-${LUAJIT_VERSION}
tar xfz LuaJIT-${LUAJIT_VERSION}.tar.gz
cd LuaJIT-${LUAJIT_VERSION}
if [ ! -x Makefile.orig ]; then
  mv Makefile Makefile.orig
fi
rm -f libluajit-x86_64.a libluajit-i386.a luajit-x86_64 luajit-i386
sed -e "s#PREFIX= /usr/local#PREFIX= ${EXTERNAL_LIBRARY_DIR}/luajit#" Makefile.orig > Makefile
make clean
make CC=clang CFLAGS="-O3 -mmacosx-version-min=10.6 -arch i386" LDFLAGS="-arch i386" BUILDMODE=static -j 4
mv src/libluajit.a libluajit-i386.a
mv src/luajit luajit-i386
make clean
make CC=clang CFLAGS="-O3 -mmacosx-version-min=10.6 -arch x86_64 -m64" LDFLAGS="-arch x86_64" BUILDMODE=static -j 4
mv src/libluajit.a libluajit-x86_64.a
mv src/luajit luajit-x86_64
lipo -create -output src/libluajit.a libluajit-x86_64.a libluajit-i386.a
lipo -create -output src/luajit luajit-x86_64 luajit-i386
make install
cd ..

# Boost 1.55 [libc++]
# ===================

BOOST_VERSION="1_55_0"
BOOST_VERSION_DOT="1.55.0"
if [ ! -f "boost_${BOOST_VERSION}.tar.bz2" ]; then
  curl -O "http://superb-dca2.dl.sourceforge.net/project/boost/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2"
fi
rm -fr boost_${BOOST_VERSION}
tar xfj boost_${BOOST_VERSION}.tar.bz2
cd boost_${BOOST_VERSION}
patch -p0 <<"BUILD_WITH_CLANG_3.4"
--- boost/atomic/detail/gcc-atomic.hpp	2013-07-20 11:01:35.000000000 -0700
+++ boost/atomic/detail/gcc-atomic.hpp	2014-03-11 13:33:48.000000000 -0700
@@ -61,7 +61,7 @@
 
     void clear(memory_order order = memory_order_seq_cst) volatile BOOST_NOEXCEPT
     {
-        __atomic_clear((bool*)&v_, atomics::detail::convert_memory_order_to_gcc(order));
+        __atomic_clear(const_cast<bool*>(&v_), atomics::detail::convert_memory_order_to_gcc(order));
     }
 };
 
@@ -958,14 +958,16 @@
 
 public:
     BOOST_DEFAULTED_FUNCTION(base_atomic(void), {})
-    explicit base_atomic(value_type const& v) BOOST_NOEXCEPT : v_(0)
+    explicit base_atomic(value_type const& v) BOOST_NOEXCEPT
     {
+        memset(&v_, 0, sizeof(v_));
         memcpy(&v_, &v, sizeof(value_type));
     }
 
     void store(value_type const& v, memory_order order = memory_order_seq_cst) volatile BOOST_NOEXCEPT
     {
-        storage_type tmp = 0;
+        storage_type tmp;
+        memset(&tmp, 0, sizeof(tmp));
         memcpy(&tmp, &v, sizeof(value_type));
         __atomic_store_n(&v_, tmp, atomics::detail::convert_memory_order_to_gcc(order));
     }
@@ -980,7 +982,8 @@
 
     value_type exchange(value_type const& v, memory_order order = memory_order_seq_cst) volatile BOOST_NOEXCEPT
     {
-        storage_type tmp = 0;
+        storage_type tmp;
+        memset(&tmp, 0, sizeof(tmp));
         memcpy(&tmp, &v, sizeof(value_type));
         tmp = __atomic_exchange_n(&v_, tmp, atomics::detail::convert_memory_order_to_gcc(order));
         value_type res;
@@ -994,7 +997,9 @@
         memory_order success_order,
         memory_order failure_order) volatile BOOST_NOEXCEPT
     {
-        storage_type expected_s = 0, desired_s = 0;
+        storage_type expected_s, desired_s;
+        memset(&expected_s, 0, sizeof(expected_s));
+        memset(&desired_s, 0, sizeof(desired_s));
         memcpy(&expected_s, &expected, sizeof(value_type));
         memcpy(&desired_s, &desired, sizeof(value_type));
         const bool success = __atomic_compare_exchange_n(&v_, &expected_s, desired_s, false,
@@ -1010,7 +1015,9 @@
         memory_order success_order,
         memory_order failure_order) volatile BOOST_NOEXCEPT
     {
-        storage_type expected_s = 0, desired_s = 0;
+        storage_type expected_s, desired_s;
+        memset(&expected_s, 0, sizeof(expected_s));
+        memset(&desired_s, 0, sizeof(desired_s));
         memcpy(&expected_s, &expected, sizeof(value_type));
         memcpy(&desired_s, &desired, sizeof(value_type));
         const bool success = __atomic_compare_exchange_n(&v_, &expected_s, desired_s, true,
--- boost/atomic/detail/cas128strong.hpp	2013-07-20 11:01:35.000000000 -0700
+++ boost/atomic/detail/cas128strong.hpp	2014-03-11 13:34:29.000000000 -0700
@@ -196,15 +196,17 @@
 
 public:
     BOOST_DEFAULTED_FUNCTION(base_atomic(void), {})
-    explicit base_atomic(value_type const& v) BOOST_NOEXCEPT : v_(0)
+    explicit base_atomic(value_type const& v) BOOST_NOEXCEPT
     {
+        memset(&v_, 0, sizeof(v_));
         memcpy(&v_, &v, sizeof(value_type));
     }
 
     void
     store(value_type const& value, memory_order order = memory_order_seq_cst) volatile BOOST_NOEXCEPT
     {
-        storage_type value_s = 0;
+        storage_type value_s;
+        memset(&value_s, 0, sizeof(value_s));
         memcpy(&value_s, &value, sizeof(value_type));
         platform_fence_before_store(order);
         platform_store128(value_s, &v_);
@@ -247,7 +249,9 @@
         memory_order success_order,
         memory_order failure_order) volatile BOOST_NOEXCEPT
     {
-        storage_type expected_s = 0, desired_s = 0;
+        storage_type expected_s, desired_s;
+        memset(&expected_s, 0, sizeof(expected_s));
+        memset(&desired_s, 0, sizeof(desired_s));
         memcpy(&expected_s, &expected, sizeof(value_type));
         memcpy(&desired_s, &desired, sizeof(value_type));
 
BUILD_WITH_CLANG_3.4
rm -fr /tmp/boost
./bootstrap.sh --with-toolset=clang
./b2 --prefix="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}-libc++" --build-dir=/tmp link=static threading=multi variant=release cxxflags="-mmacosx-version-min=10.7 -arch x86_64 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden -stdlib=libc++" --without-mpi --without-python install
cd ..

# websocketpp [libc++]
# ====================

rm -fr websocketpp
git clone git@github.com:leapmotion/websocketpp.git
cd websocketpp
CPP11_='-arch x86_64 -arch i386 -stdlib=libc++ -mmacosx-version-min=10.7 -fvisibility=hidden -fvisibility-inlines-hidden' BOOST_PREFIX="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}-libc++" prefix="${EXTERNAL_LIBRARY_DIR}/websocketpp-libc++" make install
cd ..

# Cinder
# ======

CINDER_VERSION="0.8.5"
rm -fr Cinder
git clone --branch v${CINDER_VERSION} --depth 1 https://github.com/cinder/Cinder.git
cd Cinder
patch -p0 <<"CINDER_FIX_CRASH_PATCH"
--- src/cinder/app/AppImplCocoaBasic.mm
+++ src/cinder/app/AppImplCocoaBasic.mm
@@ -544,7 +544,7 @@
 
 	[mAppImpl setActiveWindow:self];
 
-	if( displayID != mDisplay->getCgDirectDisplayId() ) {
+	if( !mDisplay || displayID != mDisplay->getCgDirectDisplayId() ) {
 		mDisplay = cinder::Display::findFromCgDirectDisplayId( displayID );
 		mWindowRef->emitDisplayChange();
 	}
CINDER_FIX_CRASH_PATCH
git submodule update --init tools/TinderBox-Mac
mv boost boost.cinder
ln -s "${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}/include" boost
cd lib
mv macosx ../lib.macosx
mkdir macosx
cd macosx
ln -s "${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}/lib/libboost_date_time.a" .
ln -s "${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}/lib/libboost_filesystem.a" .
ln -s "${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}/lib/libboost_system.a" .
ln -s "${EXTERNAL_LIBRARY_DIR}/zlib-${ZLIB_VERSION}/lib/libz.a" .
cd ../../xcode
xcrun xcodebuild -project cinder.xcodeproj -target cinder -configuration Debug
xcrun xcodebuild -project cinder.xcodeproj -target cinder -configuration Release
cd ..
mkdir "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}"
mkdir "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/lib"
mkdir "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/boost"
cp README.md "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -R blocks "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -RL boost "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -R docs "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -RL include "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -R lib/lib*.a "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/lib/"
cp -RL lib/macosx "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/lib/"
cp -R samples "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -R tools "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
cp -R tour "${EXTERNAL_LIBRARY_DIR}/cinder_${CINDER_VERSION}/"
rm -fr lib/macosx
mv lib.macosx lib/macosx
rm boost
mv boost.cinder boost
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
  clang++ -O3 -arch x86_64 -arch i386 -std=c++11 -stdlib=libc++ -mmacosx-version-min=10.7 -fvisibility=hidden -c ${source}
done
ar cq libpolypartition.a *.o
ranlib libpolypartition.a
cp libpolypartition.a ${EXTERNAL_LIBRARY_DIR}/polypartition/lib/
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
./autogen.sh
CC="clang" CFLAGS="-O3 -arch x86_64 -arch i386 -mmacosx-version-min=10.7 -fvisibility=hidden" ./configure --prefix="${EXTERNAL_LIBRARY_DIR}/freetype-${FREETYPE_VERSION}" --without-zlib --without-bzip2 --without-png
make -j 9 && make install
cp docs/FTL.TXT "${EXTERNAL_LIBRARY_DIR}/freetype-${FREETYPE_VERSION}"/

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
CFLAGS="-mmacosx-version-min=10.7 -fvisibility=hidden" cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64;i386" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.7 -DCMAKE_OSX_SYSROOT=macosx10.11 -DFREETYPE_INCLUDE_DIR_freetype2="${EXTERNAL_LIBRARY_DIR}/freetype-2.6.3/include/freetype2" -DFREETYPE_INCLUDE_DIR_ft2build="${EXTERNAL_LIBRARY_DIR}/freetype-2.6.3/include" -DFREETYPE_LIBRARY="${EXTERNAL_LIBRARY_DIR}/freetype-2.6.3/lib/libfreetype.a" -Dfreetype-gl_BUILD_DEMOS=OFF -Dfreetype-gl_BUILD_APIDOC=OFF -Dfreetype-gl_BUILD_MAKEFONT=OFF
make -j 9
mkdir -p "${EXTERNAL_LIBRARY_DIR}/freetype-gl/include" 
mkdir -p "${EXTERNAL_LIBRARY_DIR}/freetype-gl/lib" 
cp libfreetype-gl.a "${EXTERNAL_LIBRARY_DIR}/freetype-gl/lib/"
cd ..
cp freetype-gl.h opengl.h texture-atlas.h texture-font.h vec234.h vector.h "${EXTERNAL_LIBRARY_DIR}/freetype-gl/include/"
cd ..

# Breakpad [libc++]
# =================

BREAKPAD_VERSION=0.1
rm -fr breakpad-${BREAKPAD_VERSION}
svn checkout http://google-breakpad.googlecode.com/svn/trunk/@1374 breakpad-${BREAKPAD_VERSION}
cd breakpad-${BREAKPAD_VERSION}
BREAKPAD_DIR="${EXTERNAL_LIBRARY_DIR}/breakpad-${BREAKPAD_VERSION}-libc++"
BREAKPAD_INCLUDE="${BREAKPAD_DIR}/include"
BREAKPAD_BIN="${BREAKPAD_DIR}/bin"
BREAKPAD_LIB="${BREAKPAD_DIR}/lib"

CC=clang CXX=clang++ CFLAGS="-O3 -arch x86_64"  CXXFLAGS="-O3 -arch x86_64 -stdlib=libc++" ./configure --prefix="${BREAKPAD_DIR}"
make -j 4 && make install

cd src
for f in $(find client common google_breakpad processor testing -name \*.h); do
  mkdir -p "${BREAKPAD_INCLUDE}/$(dirname $f)"
  cp "$f" "${BREAKPAD_INCLUDE}/$(dirname $f)/"
done
cd ..

xcodebuild -sdk macosx10.9 -project src/tools/mac/dump_syms/dump_syms.xcodeproj -destination 'platform=OS X' GCC_VERSION=com.apple.compilers.llvm.clang.1_0 MACOSX_DEPLOYMENT_TARGET=10.7 OTHER_CPLUSPLUSFLAGS="-stdlib=libc++" OTHER_LDFLAGS="-stdlib=libc++"
xcodebuild -sdk macosx10.9 -project src/client/mac/Breakpad.xcodeproj -destination 'platform=OS X' -target Breakpad GCC_VERSION=com.apple.compilers.llvm.clang.1_0 MACOSX_DEPLOYMENT_TARGET=10.7 OTHER_CPLUSPLUSFLAGS="-stdlib=libc++" OTHER_LDFLAGS="-stdlib=libc++"

cp src/tools/mac/dump_syms/build/Release/dump_syms "${BREAKPAD_DIR}/bin/"
cp -R src/tools/mac/dump_syms/build/Release/dump_syms.dSYM "${BREAKPAD_DIR}/bin/"
cp -R src/client/mac/build/Release/Breakpad.framework "${BREAKPAD_DIR}/lib/"
cd ..

# SWIG
# ====

SWIG_VERSION=3.0.8
PCRE_VERSION=8.38

if [ ! -f swig-${SWIG_VERSION}.tar.gz ]; then
  curl -O "http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz"
fi
if [ ! -f pcre-${PCRE_VERSION}.tar.bz2 ]; then
  curl -O "http://iweb.dl.sourceforge.net/project/pcre/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.bz2"
fi

rm -fr swig-${SWIG_VERSION}
tar xfz "swig-${SWIG_VERSION}.tar.gz"
cd swig-${SWIG_VERSION}
tar xfj "../pcre-${PCRE_VERSION}.tar.bz2"
cd pcre-${PCRE_VERSION}
./configure --enable-shared=no --prefix="`pwd`/../pcre"
make -j 4 && make install
cd ..
./configure --with-pcre --with-pcre-prefix="`pwd`/pcre" --prefix="${EXTERNAL_LIBRARY_DIR}/swig-3.0.8" --with-boost="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}-libc++"
make -j 4 && make install
cd ..
