@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src

mkdir freetypegl-build
cd freetypegl-build

call %CMAKE_COMMAND% ../%1 -G "Visual Studio 14 2015 Win64" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" -Dfreetype-gl_BUILD_DEMOS:BOOL="false" -Dfreetype-gl_BUILD_APIDOC:BOOL="false"
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
