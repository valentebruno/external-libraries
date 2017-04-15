@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

mkdir build
cd build

if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)

call %CMAKE_COMMAND% ../ -G"%CMAKE_GEN%" -Wno-dev -DCMAKE_INSTALL_PREFIX:PATH="%2" ^
-DFREETYPE_INCLUDE_DIR_freetype2="%FREETYPE2_PATH%/include/freetype2" ^
-DFREETYPE_INCLUDE_DIR_ft2build="%FREETYPE2_PATH%/include" ^
-DFREETYPE_LIBRARY="${FREETYPE2_PATH}/lib/libfreetype.lib" ^
-Dfreetype-gl_BUILD_DEMOS:BOOL=OFF -Dfreetype-gl_BUILD_APIDOC:BOOL=OFF ^
-Dfreetype-gl_BUILD_MAKEFONT:BOOL=OFF -Dfreetype-gl_BUILD_TESTS:BOOL=OFF

call %CMAKE_COMMAND% --build . --target freetype-gl --config Debug
call %CMAKE_COMMAND% --build . --target freetype-gl --config Release

mkdir %2\lib
copy Debug\freetype-gl.lib %2\lib\freetype-gl-d.lib
copy Release\freetype-gl.lib %2\lib\freetype-gl.lib

xcopy /si ..\texture-font.h %2\include\
xcopy /si ..\vec234.h %2\include\
xcopy /si ..\vector.h %2\include\
xcopy /si ..\freetype-gl.h %2\include\
xcopy /si ..\opengl.h %2\include\
xcopy /si ..\texture-atlas.h %2\include\

@endlocal
