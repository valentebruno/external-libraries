@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src

mkdir freetypegl-build
cd freetypegl-build

if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)

call %CMAKE_COMMAND% . -G"%CMAKE_GEN%" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" -Dfreetype-gl_BUILD_DEMOS:BOOL="false" -Dfreetype-gl_BUILD_APIDOC:BOOL="false"
call %CMAKE_COMMAND% --build . --target freetype-gl --config Debug
call %CMAKE_COMMAND% --build . --target freetype-gl --config Release

mkdir %2\lib
copy Debug\freetype-gl.lib %2\lib\freetype-gl-d.lib
copy Release\freetype-gl.lib %2\lib\freetype-gl.lib

xcopy /si ..\%1\texture-font.h %2\include\
xcopy /si ..\%1\vec234.h %2\include\
xcopy /si ..\%1\vector.h %2\include\
xcopy /si ..\%1\freetype-gl.h %2\include\
xcopy /si ..\%1\opengl.h %2\include\
xcopy /si ..\%1\texture-atlas.h %2\include\

@endlocal
