@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
call %CMAKE_COMMAND% -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" -DFLATBUFFERS_BUILD_TESTS:BOOL=false
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release
@endlocal
