@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
@cd cmake

if "%MSVC_VER%"=="2017" (
  set CMAKE_GEN=Visual Studio 15 2017
)
if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)

call %CMAKE_COMMAND% -Dprotobuf_BUILD_TESTS:BOOL=false -Dprotobuf_MSVC_STATIC_RUNTIME:BOOL=false -Dprotobuf_WITH_ZLIB:BOOL=true -DZLIB_ROOT:PATH="%2/../zlib-1.2.8" -G"%CMAKE_GEN%" -DCMAKE_INSTALL_PREFIX=%2
call %CMAKE_COMMAND% --build . --target install --config debug
call %CMAKE_COMMAND% --build . --target install --config release

@endlocal
