@setlocal
@echo path=%OPENSSL_PATH%
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

@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

call buildconf.bat
@nmake /f Makefile.dist vc-x64-ssl-zlib
@if NOT %ERRORLEVEL% == 0 (
  echo NMake failed, aborting
  exit 1
  )

echo err=%ERRORLEVEL%
mkdir %2\%3
mkdir %2\%3\include
mkdir %2\%3\include\curl
mkdir %2\%3\lib
copy include\curl\*.h %2\%3\include\curl\
copy lib\libcurl.lib %2\%3\lib\

@endlocal
