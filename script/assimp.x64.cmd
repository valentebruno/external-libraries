@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

set ZLIB_HOME=%2\..\zlib-1.2.8
echo ZLIB_HOME=%ZLIB_HOME%
call %CMAKE_COMMAND% -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" -DASSIMP_BUILD_TESTS:BOOL="false" -DASSIMP_BUILD_ASSIMP_TOOLS:BOOL="false" -DBUILD_SHARED_LIBS:BOOL="false" -DDirectX_D3DX9_LIBRARY:FILEPATH=""
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release

@endlocal
