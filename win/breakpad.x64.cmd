@setlocal

:: http://zxstudio.org/blog/2014/10/28/integrating-google-breakpad/

@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src
@set PATH=%cd%\gyp-0.1;%PATH%

@cd %1

call gyp.bat --no-circular-check src\client\windows\breakpad_client.gyp -Dwin_release_RuntimeLibrary=2 -Dwin_debug_RuntimeLibrary=2 -DMSVS_VERSION=2015

msbuild src\client\windows\handler\exception_handler.vcxproj /p:Configuration=Debug;Platform=x64
msbuild src\client\windows\handler\exception_handler.vcxproj /p:Configuration=Release;Platform=x64

@endlocal
