@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
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
-DBUILD_BULLET2_DEMOS:BOOL="false" -DBUILD_CPU_DEMOS:BOOL="false" -DBUILD_EXTRAS:BOOL="false" ^
-DBUILD_OPENGL3_DEMOS="false" -DBUILD_UNIT_TESTS:BOOL="false" -DINSTALL_LIBS="true" ^
-DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON

call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release
@endlocal
