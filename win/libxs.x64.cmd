@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

pushd builds\msvc
devenv /Upgrade msvc10.sln
msbuild libxs/libxs.vcxproj /p:Configuration=Debug;Platform=x64
msbuild libxs/libxs.vcxproj /p:Configuration=Release;Platform=x64
popd

xcopy doc %2\doc /E /I
xcopy include %2\include /E /I
xcopy lib %2\lib /E /I
@endlocal
