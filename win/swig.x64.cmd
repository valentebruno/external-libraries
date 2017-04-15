@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src

xcopy /S %1\* %2\
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

call %CMAKE_COMMAND% .. -G"%CMAKE_GEN%" -DCMAKE_INSTALL_PREFIX=%2
call %CMAKE_COMMAND% --build . --target install --config debug
call %CMAKE_COMMAND% --build . --target install --config release
@endlocal
