CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
mkdir C:\Libraries-x64_vc14\zlib-1.2.8
mkdir C:\Libraries-x64_vc14\zlib-1.2.8\include
mkdir C:\Libraries-x64_vc14\zlib-1.2.8\lib
copy zconf.h C:\Libraries-x64_vc14\zlib-1.2.8\include
copy zlib.h C:\Libraries-x64_vc14\zlib-1.2.8\include
copy zlib.lib C:\Libraries-x64_vc14\zlib-1.2.8\lib
