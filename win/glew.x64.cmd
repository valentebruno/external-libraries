@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1\

pushd build\vc12
devenv /Upgrade glew.sln
msbuild glew_static.vcxproj /p:Configuration=Debug;Platform=x64
msbuild glew_static.vcxproj /p:Configuration=Release;Platform=x64
msbuild glew_shared.vcxproj /p:Configuration=Debug;Platform=x64
msbuild glew_shared.vcxproj /p:Configuration=Release;Platform=x64
msbuild glewinfo.vcxproj /p:Configuration=Release;Platform=x64
msbuild visualinfo.vcxproj /p:Configuration=Release;Platform=x64
popd

xcopy /si lib\Release\x64 %2\lib\
xcopy /si lib\Debug\x64 %2\lib\
xcopy /si include %2\include\
xcopy /si bin\Debug\x64\glew32d.dll %2\bin\
xcopy /si bin\Release\x64\glew32.dll %2\bin\
xcopy /si bin\Release\x64\glewinfo.exe %2\bin\
xcopy /si bin\Release\x64\visualinfo.exe %2\bin\
xcopy /si doc %2\doc\
@endlocal
