@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1\

devenv /Upgrade FreeImage.2013.sln
msbuild Source\FreeImageLib\FreeImageLib.2013.vcxproj /p:Configuration=Debug;Platform=x64
msbuild Source\FreeImageLib\FreeImageLib.2013.vcxproj /p:Configuration=Release;Platform=x64

xcopy /si Source\FreeImage.h %2\include\
xcopy /si Dist\x64\FreeImageLib*.lib %2\lib
@endlocal
