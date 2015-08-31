Qt 5.5 for Windows
==================
This document provides the instructions that were used to build Qt 5.5 for Windows.

Prerequisites
=============
In order to build Qt 5.5 for Windows, you must first have various tools installed on your system. This list of [requirements for Windows](http://doc.qt.io/qt-5/windows-requirements.html) was initially obtained by referring to the Qt website.

Windows 8 SDK
-------------
Make sure that you have the [Windows 8.0 SDK](https://msdn.microsoft.com/en-us/windows/desktop/hh852363.aspx) installed on your computer. If you are running Windows 8.0, you may install the entire SDK. However, if you are running a newer version of Windows, the entire SDK may not fully install, producing an error in the process. When prompted for the components to install, deselect all but the actual SDK, which appears as the frst item. For these operating systems, you may also install the entire [Windows 8.1 SDK](https://msdn.microsoft.com/en-us/windows/desktop/bg162891.aspx)).

Perl
----
You will need to install [ActivePerl](http://www.activestate.com/activeperl/downloads) in order to build QtWebKit. The scripts below assume the 64-bit version of Perl, but installing the 32-bit version is also acceptable. Just make sure that the scripts below are modified accordingly.

Python
------
You will need to have a version of [Python 2.x](https://www.python.org/downloads/) installed on your system. The scripts below assume a 64-bit version of Pythong 2.7, but a 32-bit version may be used instead. You will just need to modify the scripts to specify the actual location of the installation.

Ruby
----
You will also need to have [Ruby](http://rubyinstaller.org/downloads/) installed on your system in order to build QtWebKit component of Qt. It shouldn't matter if you install the 32-bit or 64-bit version. The scripts below assume that you are using the 64-bit version, and will need to be modified if the install paths differ.

OpenSSL / ICU
-------------
The OpenSLL and ICU packages are pre-built, and are available in the external libraries directory. The scripts below are assuming that ICU 55.1 is being used, and found in the `icu-55.1` subdirectory under the appropriate external libraries directory. If different versions are being used, adjust the scripts below accordingly.

Building Qt
===========
The instructions below provide the steps used for building both 64-bit and 32-bit versions of Qt, with both debug and release flavors being built. They were tailored after the instructions for [building Qt for Windows](http://doc.qt.io/qt-5/windows-building.html) provided on the Qt website.

* Create a `C:\qt` directory.
* Download the open source version of the [source code](http://download.qt.io/official_releases/qt/5.5/5.5.0/single/qt-everywhere-opensource-src-5.5.0.zip) from the Qt website. Make sure that you get the ZIP version, as it contains a `configure.exe` file that is needed to properly configure the build settings on Windows. The tar balls do not have that executable.
* Unzip the contents of the ZIP file into `C:\qt`, then rename the resulting top-level `qt-everywhere-opensource-src-5.5.0` subdirectory to `qt-5.5.0`.
* Qt 5.5 doesn't properly support linking in static ICU libraries when building Qt dynamically. To workaround this, we will ignore the static/shared check, and always link in with the static versions, regardless of how Qt is being built. Additionally, since we  are building with [Desktop OpenGL support, and not ANGLE,](https://wiki.qt.io/Qt_5_on_Windows_ANGLE_and_OpenGL) we need to patch a QtWebEngine configuration file too (see [QTBUG-47058](https://bugreports.qt.io/browse/QTBUG-47058)). Create a file called [`qt5.patch`](qt5.patch) with the following contents, and place it in the top-level `c:\qt` directory:

```
--- qtbase/src/3rdparty/icu_dependency.pri.orig	Thu Aug 27 11:28:10 2015
+++ qtbase/src/3rdparty/icu_dependency.pri	Thu Aug 27 11:31:43 2015
@@ -1,13 +1,13 @@
 win32 {
-    CONFIG(static, static|shared) {
+#   CONFIG(static, static|shared) {
         CONFIG(debug, debug|release) {
             LIBS_PRIVATE += -lsicuind -lsicuucd -lsicudtd
         } else {
             LIBS_PRIVATE += -lsicuin -lsicuuc -lsicudt
         }
-    } else {
-        LIBS_PRIVATE += -licuin -licuuc -licudt
-    }
+#   } else {
+#       LIBS_PRIVATE += -licuin -licuuc -licudt
+#   }
 } else {
     LIBS_PRIVATE += -licui18n -licuuc -licudata
 }
--- qtwebkit/Source/WTF/WTF.pri.orig	Thu Aug 27 11:29:42 2015
+++ qtwebkit/Source/WTF/WTF.pri	Thu Aug 27 11:30:11 2015
@@ -15,15 +15,15 @@
     LIBS += -licucore
 } else:!use?(wchar_unicode): {
     win32 {
-        CONFIG(static, static|shared) {
+#       CONFIG(static, static|shared) {
             CONFIG(debug, debug|release) {
                 LIBS += -lsicuind -lsicuucd -lsicudtd
             } else {
                 LIBS += -lsicuin -lsicuuc -lsicudt
             }
-        } else {
-            LIBS += -licuin -licuuc -licudt
-        }
+#       } else {
+#           LIBS += -licuin -licuuc -licudt
+#       }
     }
     else:!contains(QT_CONFIG,no-pkg-config):packagesExist("icu-i18n"): PKGCONFIG *= icu-i18n
     else:android: LIBS += -licui18n -licuuc
--- qtwebkit/Tools/qmake/config.tests/icu/icu.pro.orig	Thu Aug 27 14:02:05 2015
+++ qtwebkit/Tools/qmake/config.tests/icu/icu.pro	Thu Aug 27 14:02:36 2015
@@ -3,16 +3,16 @@
 CONFIG -= qt dylib

 win32 {
-    CONFIG(static, static|shared) {
+#   CONFIG(static, static|shared) {
         LIBS += $$QMAKE_LIBS_CORE
         CONFIG(debug, debug|release) {
             LIBS += -lsicuind -lsicuucd -lsicudtd
         } else {
             LIBS += -lsicuin -lsicuuc -lsicudt
         }
-    } else {
-        LIBS += -licuin -licuuc -licudt
-    }
+#   } else {
+#       LIBS += -licuin -licuuc -licudt
+#   }
 } else:!contains(QT_CONFIG,no-pkg-config):packagesExist("icu-i18n") {
     PKGCONFIG += icu-i18n
 } else {
--- qtwebengine/src/core/qtwebengine.gypi
+++ qtwebengine/src/core/qtwebengine.gypi
@@ -78,6 +78,11 @@
           },
         },
       }],
+      ['qt_os=="win32" and qt_gl=="opengl"', {
+        'include_dirs': [
+          '<(chromium_src_dir)/third_party/khronos',
+        ],
+      }],
       ['OS=="win"', {
         'resource_include_dirs': [
           '<(SHARED_INTERMEDIATE_DIR)/webkit',
```

As was mentioned in the Prerequisites section, the scripts below assume that you have installed the 64-bit version of ActivePerl, and that it is installed in `C:\Perl64`. You have installed Python 2.7, and it is located in `C:\Python27-x64`. Also, that you have a 64-bit version of Ruby 2.2 installed, and it is in `C:\Ruby22-x64`. If you are using the 32-bit versions, or you installed them in different locations, adjust the `SET PATH` lines accordingly.

It is recommended that you confirm that executing `perl`, `python` and `ruby` work successfully, after executing the `call qt5vars-x64.cmd` line below.

We will be using different build directories (`build64` and `build32`), so you will be able to build both 32-bit and 64-bit versions of Qt simultaneously if you desire.

*WARNING*: If you have Avast! installed, make sure you uninstall it before attempting to build. Their Deep Screen feature will scan various executables that are created during the build process. This will result in corrupt files, access violations, and hangs. Disabling the feature and/or disabling all of Avast! is not enough, as it still runs for some reason.


64-bit Build
------------
* Create a [`qt5vars-x64.cmd`](qt5vars-x64.cmd) file in the top-level `C:\qt` directory with the following contents (again, change the various paths as needed):
```
CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64
SET _ROOT=C:\qt\qt-5.5.0
SET PATH=C:\Libraries-x64_vc12\icu-55.1\bin;%PATH%
SET PATH=C:\Perl64;%PATH%
SET PATH=C:\Python27-x64;%PATH%
SET PATH=C:\Ruby22-x64\bin;%PATH%
SET PATH=%_ROOT%\qtbase\bin;%_ROOT%\gnuwin32\bin;%PATH%
REM Uncomment the below line when using a git checkout of the source repository
REM SET PATH=%_ROOT%\qtrepotools\bin;%PATH%
SET QMAKESPEC=win32-msvc2013
SET _ROOT=
```
* Start a new DOS command shell, and type:
```
cd c:\qt
call qt5vars-x64.cmd
cd qt-5.5.0
"C:\Program Files (x86)\Git\bin\patch.exe" -p0 ../qt5.patch
cd ..
mkdir build64
cd build64
```
* You should now have the proper build environment, and you are ready to configure Qt. Note that the `-no-icu` setting applies to building the QtCore component. However, we need ICU in order to build QtWebKit, but that is done by specifying the include and library paths that follow the `-no-icu` option:
```
..\configure.bat -no-avx2 -no-avx -no-sse4.2 -no-sse4.1 -c++11 ^
-prefix "C:\Libraries-x64_vc12\qt-5.5.0" ^
-opensource -confirm-license -debug-and-release ^
-opengl desktop -no-angle -no-incredibuild-xge ^
-nomake examples -nomake tests -platform win32-msvc2013 -mp -openssl-linked ^
-I "C:\Libraries-x64_vc12\openssl\include" ^
-L "C:\Libraries-x64_vc12\openssl\lib\release" ^
OPENSSL_LIBS="-lUser32 -lAdvapi32 -lGdi32 -lWs2_32 -lWinmm -lWldap32 -lssleay32 -llibeay32" ^
-no-icu -I "C:\Libraries-x64_vc12\icu-55.1\include" -L "C:\Libraries-x64_vc12\icu-55.1\lib"
```
* If the configuration succeeds without an error, build Qt by typing `nmake` at the prompt. This will take a _very_ long time, relatively speaking.
* If the build was successful, you can then install Qt using `nmake install`. This will install into the prefix directory that was specified during the configuration step.

32-bit Build
------------
The 32-bit build is similar to the 64-bit build, but you need to make some small changes.
* Copy [`qt5vars-x64.cmd`](qt5vars-x64.cmd) to [`qt5vars-x86.cmd`](qt5vars-x86.cmd), and replace the instance of `Libraries-x64_vc12` with `Libraries-x86_vc12` in [`qt5vars-x86.cmd`](qt5vars-x86.cmd). Also change the architecture at the end of the first time from `amd64` to `x86`. It should look like this:
```
CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
SET _ROOT=C:\qt\qt-5.5.0
SET PATH=C:\Libraries-x86_vc12\icu-55.1\bin;%PATH%
SET PATH=C:\Perl64;%PATH%
SET PATH=C:\Python27-x64;%PATH%
SET PATH=C:\Ruby22-x64\bin;%PATH%
SET PATH=%_ROOT%\qtbase\bin;%_ROOT%\gnuwin32\bin;%PATH%
REM Uncomment the below line when using a git checkout of the source repository
REM SET PATH=%_ROOT%\qtrepotools\bin;%PATH%
SET QMAKESPEC=win32-msvc2013
SET _ROOT=
```
* Start a new DOS command shell, and type:
```
cd c:\qt
call qt5vars-x86.cmd
cd qt-5.5.0
mkdir build32
cd build32
```
*  The configuration is similar to the 64-bit build, with the differences being the external libraries directory (as specified in the prefix and paths to OpenSSL and ICU):
```
..\configure.bat -no-avx2 -no-avx -no-sse4.2 -no-sse4.1 -c++11 ^
-prefix "C:\Libraries-x86_vc12\qt-5.5.0" ^
-opensource -confirm-license -debug-and-release ^
-opengl desktop -no-angle -no-incredibuild-xge ^
-nomake examples -nomake tests -platform win32-msvc2013 -mp -openssl-linked ^
-I "C:\Libraries-x86_vc12\openssl\include" ^
-L "C:\Libraries-x86_vc12\openssl\lib\release" ^
OPENSSL_LIBS="-lUser32 -lAdvapi32 -lGdi32 -lWs2_32 -lWinmm -lWldap32 -lssleay32 -llibeay32" ^
-no-icu -I "C:\Libraries-x86_vc12\icu-55.1\include" -L "C:\Libraries-x86_vc12\icu-55.1\lib"
```
* Just as with teh 64-bit version, if the configuration was successful, run `nmake` followed by `nmake install`.
