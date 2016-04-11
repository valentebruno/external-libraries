zlib for Windows
================
The instructions here are provided to build static release versions of the zlib library for both 32-bit and 64-bit:

* Download the [zlib source code](http://zlib.net/zlib128.zip). This document assumes version 1.2.8, `zlib128.zip`. If you install a different version, adjust instances of `zlib-1.2.8`, that appear in the various scripts, with the appropriate version number.
* Unzip the contents of `zlib128.zip` into `C:\`. If you use the Windows _Extract All..._ feature when right-clicking on the zip file, change the path from `C:\zlib128` to just `C:\`; this will create a `C:\zlib-1.2.8` directory.
* To create the 64-bit version of zlib, open a DOS Command Prompt, then type:

```
cd C:\zlib-1.2.8
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
mkdir C:\Libraries-x64_vc14\zlib-1.2.8
mkdir C:\Libraries-x64_vc14\zlib-1.2.8\include
mkdir C:\Libraries-x64_vc14\zlib-1.2.8\lib
copy zconf.h C:\Libraries-x64_vc14\zlib-1.2.8\include
copy zlib.h C:\Libraries-x64_vc14\zlib-1.2.8\include
copy zlib.lib C:\Libraries-x64_vc14\zlib-1.2.8\lib
```
* In order be sure not to mix the 32-bit and 64-bit builds, remove the `zlib-1.2.8` directory, then again unzip the contents of the zlib source zip file into `C:\`.
* To create the 32-bit version of the libraries, open a DOS Command Prompt, then type:

```
cd C:\zlib-1.2.8
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
nmake -f win32/Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj"
mkdir C:\Libraries-x86_vc14\zlib-1.2.8
mkdir C:\Libraries-x86_vc14\zlib-1.2.8\include
mkdir C:\Libraries-x86_vc14\zlib-1.2.8\lib
copy zconf.h C:\Libraries-x86_vc14\zlib-1.2.8\include
copy zlib.h C:\Libraries-x86_vc14\zlib-1.2.8\include
copy zlib.lib C:\Libraries-x86_vc14\zlib-1.2.8\lib
```
