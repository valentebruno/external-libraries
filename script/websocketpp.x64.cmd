@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
call %CMAKE_COMMAND% -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX=%2
call %CMAKE_COMMAND% --build . --target install --config debug
call %CMAKE_COMMAND% --build . --target install --config release
@endlocal
