@setlocal
@call %VSSETUP_COMMAND%

@if NOT DEFINED ZLIB_PATH (
  echo ZLIB_PATH must be defined
  exit 1
)

@if NOT DEFINED OPENSSL_PATH (
  echo OPENSSL_PATH must be defined
  exit 1
)

@if NOT EXIST %ZLIB_PATH% (
  echo ZLIB_PATH must be set to real directories
  exit 1
)

@if NOT EXIST %OPENSSL_PATH% (
  echo OPENSSL_PATH must be set to real directories
  exit 1
)


cd src\%1
if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)
call %CMAKE_COMMAND% . -G"%CMAKE_GEN%" -DCMAKE_INSTALL_PREFIX=%2 -DCURL_STATICLIB:BOOL="ON"
call %CMAKE_COMMAND% --build . --target install --config debug
call %CMAKE_COMMAND% --build . --target install --config release

@endlocal
