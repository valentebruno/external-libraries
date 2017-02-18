@setlocal
@set root_dir=%CD%
@cd src\%1
@call %VSSETUP_COMMAND%

if "%MSVC_VER%"=="2015" (
  set TOOLSET=msvc-14.0
)

if "%MSVC_VER%"=="2013" (
  set TOOLSET=msvc-12.0
  set VS140COMNTOOLS=
)

set BUILD_DIR=build
if "%BUILD_ARCH%"=="x64" (
  set BUILD_DIR=%BUILD_DIR%64
  set MEM_OPT=address-model=64
  set BUILD_ARCH="ia64"
)

@call bootstrap.bat
@b2 toolset=%TOOLSET% --with-atomic --with-chrono --with-date_time --with-filesystem --with-locale --with-program_options --with-thread ^
 -j8 --build-dir=%root_dir%\%BUILD_DIR%\%1 --prefix=%2 ^
  variant=debug variant=release link=static runtime-link=shared architecture=%BUILD_ARCH% %MEM_OPT% install

@endlocal
