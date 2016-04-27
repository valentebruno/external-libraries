@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1
call %CMAKE_COMMAND% -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" -DBUILD_BULLET2_DEMOS:BOOL="false" -DBUILD_CPU_DEMOS:BOOL="false" -DBUILD_EXTRAS:BOOL="false" -DBUILD_OPENGL3_DEMOS="false" -DBUILD_UNIT_TESTS:BOOL="false" -DINSTALL_LIBS="true"
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release
@endlocal
