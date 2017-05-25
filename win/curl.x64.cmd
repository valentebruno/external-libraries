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

cd src\%1\winbuild

if MSVC_VER EQU 2013 (
  set VC=12
)

if MSVC_VER EQU 2015 (
  set VC=14
)
if MSVC_VER EQU 2015 (
  set VC=15
)


@nmake /f Makefile.vc mode=static VC=%VC% MACHINE=%BUILD_ARCH% DEBUG=yes
@if NOT %ERRORLEVEL% == 0 (
  echo NMake failed, aborting
  exit 1
)

@nmake /f Makefile.vc mode=static VC=%VC% MACHINE=%BUILD_ARCH% DEBUG=no
@if NOT %ERRORLEVEL% == 0 (
  echo NMake failed, aborting
  exit 1
)

cd ..
mkdir %2
mkdir %2\include
mkdir %2\include\curl
mkdir %2\lib
copy include\curl\*.h %2\include\curl\
copy builds\libcurl-vc-%BUILD_ARCH%-debug-static-ipv6-sspi-winssl\lib\libcurl_a_debug.lib %2\lib\libcurld.lib
copy builds\libcurl-vc-%BUILD_ARCH%-release-static-ipv6-sspi-winssl\lib\libcurl_a.lib %2\lib\libcurl.lib

@endlocal
