ICU for Windows
===============
The instructions here are provided to build static debug and release versions of the ICU library for both 32-bit and 64-bit:

* Download the [ICU source code](http://site.icu-project.org/download). This document assumes version 55.1, `icu4c-55_1-src.zip`. If you install a different version, adjust instances of `icu-55.1`, that appear in the various scripts, with the appropriate version number.
* If you don't already have it, install `make` from [sourceforge.net](http://sourceforge.net/projects/mingw/files/MSYS/Base/make/make-3.81-3/) into `/usr/local/bin/` for use by msysGit (using Windows paths, it is likely `C:\Program Files (x86)\Git\local\bin`).

* The compiler options aren't properly set in the `configure` script to allow us to build a pure Windows debug library that works with MSVC. Therefore, we will apply a patch, that may be overkill, but it will guarantee that we build with the proper settings. Create a file called `icu.patch` with the following contents, and place it in the `C:\qt` directory.

```
--- runConfigureICU	Thu Aug 27 11:17:40 2015
+++ runConfigureICU.good	Thu Aug 27 11:17:30 2015
@@ -316,16 +316,27 @@
         CXXFLAGS="--std=c++03"
         export CXXFLAGS
         ;;
-    MSYS/MSVC)
+    MSYS/MSVC/Debug)
         THE_OS="MSYS"
         THE_COMP="Microsoft Visual C++"
         CC=cl; export CC
         CXX=cl; export CXX
-        RELEASE_CFLAGS='-Gy -MD'
-        RELEASE_CXXFLAGS='-Gy -MD'
+        RELEASE_CFLAGS='-Zi -MDd'
+        RELEASE_CXXFLAGS='-Zi -MDd'
+        RELEASE_LDFLAGS='-DEBUG'
         DEBUG_CFLAGS='-Zi -MDd'
         DEBUG_CXXFLAGS='-Zi -MDd'
         DEBUG_LDFLAGS='-DEBUG'
+        ;;
+    MSYS/MSVC/Release)
+        THE_OS="MSYS"
+        THE_COMP="Microsoft Visual C++"
+        CC=cl; export CC
+        CXX=cl; export CXX
+        RELEASE_CFLAGS='-Gy -MD'
+        RELEASE_CXXFLAGS='-Gy -MD'
+        DEBUG_CFLAGS='-Gy -MD'
+        DEBUG_CXXFLAGS='-Gy -MD'
         ;;
     *BSD)
         THE_OS="BSD"
```
* Unzip the contents of ICU source zip file into `C:\qt`. This will create an `icu` directory.
* To create the 64-bit version of ICU, open a DOS Command Prompt, then type:

```
cd c:\qt
call qt5vars-x64
cd icu\source
"C:\Program Files (x86)\Git\bin\bash.exe"
export PATH=/c/Program\ Files\ \(x86\)/Git/bin:/c/Program\ Files\ \(x86\)/Git/local/bin:$PATH
patch < ../../icu.patch
./runConfigureICU MSYS/MSVC/Debug --enable-debug --enable-static --disable-shared --prefix=C:/Libraries-x64_vc12/icu-55.1
make
make install
rm /c/Libraries-x64_vc12/icu-55.1/lib/sicudtd.dll
make clean
./runConfigureICU MSYS/MSVC/Release --enable-static --disable-shared --prefix=C:/Libraries-x64_vc12/icu-55.1
make
make install
rm /c/Libraries-x64_vc12/icu-55.1/lib/sicudt.dll
```
* In order be sure not to mix the 32-bit and 64-bit builds, remove the `icu` directory, then again unzip the contents of the ICU source zip file into `c:\qt`.
* To create the 32-bit version of the libraries, open a DOS Command Prompt, then type:

```
cd c:\qt
call qt5vars-x86
cd icu\source
"C:\Program Files (x86)\Git\bin\bash.exe"
export PATH=/c/Program\ Files\ \(x86\)/Git/bin:/c/Program\ Files\ \(x86\)/Git/local/bin:$PATH
patch < ../../icu.patch
./runConfigureICU MSYS/MSVC/Debug --enable-debug --enable-static --disable-shared --prefix=C:/Libraries-x86_vc12/icu-55.1
make
make install
rm /c/Libraries-x86_vc12/icu-55.1/lib/sicudtd.dll
make clean
./runConfigureICU MSYS/MSVC/Release --enable-static --disable-shared --prefix=C:/Libraries-x86_vc12/icu-55.1
make
make install
rm /c/Libraries-x86_vc12/icu-55.1/lib/sicudt.dll
```
