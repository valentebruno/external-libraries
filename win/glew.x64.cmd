@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1\

pushd build\vc12
devenv /Upgrade glew.sln
msbuild glew_static.vcxproj /p:Configuration=Debug;Platform=%BUILD_ARCH%
msbuild glew_static.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
msbuild glew_shared.vcxproj /p:Configuration=Debug;Platform=%BUILD_ARCH%
msbuild glew_shared.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
msbuild glewinfo.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
msbuild visualinfo.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
popd

if "%BUILD_ARCH%"=="x86" (
  set GLEW_ARCH_SUBDIR=Win32
)
if "%BUILD_ARCH%"=="x64" (
  set GLEW_ARCH_SUBDIR=Win64
)


xcopy /si lib\Release\%GLEW_ARCH_SUBDIR% %2\lib\
xcopy /si lib\Debug\%GLEW_ARCH_SUBDIR% %2\lib\
xcopy /si include %2\include\
xcopy /si bin\Debug\%GLEW_ARCH_SUBDIR%\glew32d.dll %2\bin\
xcopy /si bin\Release\%GLEW_ARCH_SUBDIR%\glew32.dll %2\bin\
xcopy /si bin\Release\%GLEW_ARCH_SUBDIR%\glewinfo.exe %2\bin\
xcopy /si bin\Release\%GLEW_ARCH_SUBDIR%\visualinfo.exe %2\bin\
xcopy /si doc %2\doc\
@endlocal
