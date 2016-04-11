CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
nmake -f win32/Makefile.msc LOC="-DASMV -DASMINF" OBJA="inffas32.obj match686.obj"
mkdir C:\Libraries-x86_vc14\zlib-1.2.8
mkdir C:\Libraries-x86_vc14\zlib-1.2.8\include
mkdir C:\Libraries-x86_vc14\zlib-1.2.8\lib
copy zconf.h C:\Libraries-x86_vc14\zlib-1.2.8\include
copy zlib.h C:\Libraries-x86_vc14\zlib-1.2.8\include
copy zlib.lib C:\Libraries-x86_vc14\zlib-1.2.8\lib
