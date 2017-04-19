@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

set ZLIB_HOME=%2\..\zlib-1.2.8
if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)

mkdir build
cd build

call %CMAKE_COMMAND% ../ -G"%CMAKE_GEN%" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" ^
-DASSIMP_BUILD_TESTS:BOOL="false" -DASSIMP_BUILD_ASSIMP_TOOLS:BOOL="false" ^
-DBUILD_SHARED_LIBS:BOOL="false"
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release

@endlocal
