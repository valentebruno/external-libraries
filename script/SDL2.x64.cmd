@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src

mkdir sdl-build
cd sdl-build

call %CMAKE_COMMAND% ../%1 -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2"
call %CMAKE_COMMAND% --build . --target install --config Debug
call %CMAKE_COMMAND% --build . --target install --config Release

@endlocal
