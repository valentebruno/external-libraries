@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

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

call %CMAKE_COMMAND% . -G"%CMAKE_GEN%" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2"
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release
@endlocal
