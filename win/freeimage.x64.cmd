@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1\

devenv /Upgrade FreeImage.2013.sln
msbuild Source\FreeImageLib\FreeImageLib.2013.vcxproj /p:Configuration=Debug;Platform=%BUILD_ARCH%
msbuild Source\FreeImageLib\FreeImageLib.2013.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%

xcopy /si Source\FreeImage.h %2\include\

if "%BUILD_ARCH%"=="x64" (
  set DIST_SUBDIR="x64"
)
if "%BUILD_ARCH%"=="x86" (
  set DIST_SUBDIR="x32"
)

xcopy /si Dist\%DIST_SUBDIR%\FreeImageLib*.lib %2\lib
@endlocal
