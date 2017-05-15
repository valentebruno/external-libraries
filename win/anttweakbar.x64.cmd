@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

pushd src
devenv /Upgrade AntTweakBar_VS2012.sln
msbuild AntTweakBar.vcxproj /p:Configuration=Debug;Platform=%BUILD_ARCH%
msbuild AntTweakBar.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
popd

xcopy /si include %2\include\
xcopy /si lib %2\lib\
del %2\lib\*.iobj
del %2\lib\*.ipdb

@endlocal
