@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src
set PROTOBUF_SRC=%~dpnx1
set PROTOBUF_SRC=%PROTOBUF_SRC:\=/%
cd protobuf-cmake
call %CMAKE_COMMAND% -DPROTOBUF_ROOT="%PROTOBUF_SRC%" -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX=%2\%3
call %CMAKE_COMMAND% --build . --config debug
::@call msbuild /t:INSTALL FlatBuffers.sln
::@nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
::@mkdir %2\%3
::@mkdir %2\%3\include
::@mkdir %2\%3\lib
::@copy zconf.h %2\%3\include
::@copy zlib.h %2\%3\include
::@copy zlib.lib %2\%3\lib
@endlocal
