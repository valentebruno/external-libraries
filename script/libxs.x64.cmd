@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
cd builds\msvc
msbuild msvc10.sln
::call %CMAKE_COMMAND% -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2\%3" -DFLATBUFFERS_BUILD_TESTS:BOOL=false
::call %CMAKE_COMMAND% --build . --target install --config Debug
::call %CMAKE_COMMAND% --build . --target install --config Release
::@call msbuild /t:INSTALL FlatBuffers.sln
::@nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
::@mkdir %2\%3
::@mkdir %2\%3\include
::@mkdir %2\%3\lib
::@copy zconf.h %2\%3\include
::@copy zlib.h %2\%3\include
::@copy zlib.lib %2\%3\lib
@endlocal
