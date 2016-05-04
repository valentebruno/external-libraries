@setlocal
@set root_dir=%CD%
@cd src\%1
@call %VSSETUP_COMMAND%

if "%MSVC_VER%"=="2015" (
  set TOOLSET=msvc-14.0
)
if "%MSVC_VER%"=="2013" (
  set TOOLSET=msvc-12.0
)

set BUILD_DIR=build
if "%ARCH%"=="64" (
  set BUILD_DIR=%BUILD_DIR%64
  set MEM_OPT=address-model=64
)

@call bootstrap.bat
@mkdir %root_dir%\build\%1\build64
@b2 --without-mpi --without-python -j8 --build-dir=%root_dir%\%BUILD_DIR%\%1 --prefix=%2 variant=debug variant=release link=static runtime-link=shared architecture=x86 %MEM_OPT% toolset=%TOOLSET% install
@endlocal
