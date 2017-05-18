@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

pushd builds\msvc
devenv /Upgrade msvc10.sln
msbuild libxs/libxs.vcxproj /p:Configuration=Debug;Platform=%BUILD_ARCH%
msbuild libxs/libxs.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
popd

xcopy doc %2\doc /E /I
xcopy include %2\include /E /I
xcopy bin\*.lib %2\lib\ /E /I
@endlocal
