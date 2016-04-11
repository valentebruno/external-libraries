curl for Windows
================
The instructions here are provided to build static release versions of the libcurl library for 64-bit:

* Download the [curl source code](https://curl.haxx.se/download/curl-7.47.1.zip). This document assumes version 7.47.1, `curl-7.47.1.zip`. If you install a different version, adjust instances of `curl-7.47.1`, that appear in the various scripts, with the appropriate version number.

* Modify line 23 of `curl-7.47.1/Makefile`, changing `VC=6` to `VC=14`.
* Modify lines 273 and 275 of `curl-7.47.1/Makefile`, appending ' rtlibcfg=static' to the end of line.
* Modify line 108 of `curl-7.47.1/lib/Makefile`, replacing the two instances of `inc32` with `include`.
* Modify line 111 of `curl-7.47.1/lib/Makefile`, adding `/include` before the last `"`.
* Modify line 93 of `curl-7.47.1/src/Makfile`, adding `/include` before the last `"`.
* Modify line 94 of `curl-7.47.1/src/Makefile`, adding `/lib` before the last `"`.
* Modify line 99 of `curl-7.47.1/src/Makefile`, changing `out32` to `lib`.
* Modify line 287 of `curl-7.47.1/src/Makefile`, appending `/nodefaultlib:libcmt` to the end of line.
* Set line 32 of `curl-7.47.1/src/config-win32.h` to `#define HTTP_ONLY 1`

```
cd C:\curl-7.47.1
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
set ZLIB_PATH=c:\Libraries-x64_vc14\zlib-1.2.8
set OPENSSL_PATH=c:\Libraries-x64_vc14\openssl-1.0.2g
nmake vc-x64-ssl-zlib
mkdir C:\Libraries-x64_vc14\curl-7.47.1
mkdir C:\Libraries-x64_vc14\curl-7.47.1\include
mkdir C:\Libraries-x64_vc14\curl-7.47.1\include\curl
mkdir C:\Libraries-x64_vc14\curl-7.47.1\lib
copy include\curl\*.h C:\Libraries-x64_vc14\curl-7.47.1\include\curl\
copy lib\libcurl.lib C:\Libraries-x64_vc14\curl-7.47.1\lib\
```
