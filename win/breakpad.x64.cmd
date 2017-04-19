@setlocal

:: http://zxstudio.org/blog/2014/10/28/integrating-google-breakpad/

@call %VSSETUP_COMMAND%
@cd src
@set PATH=%cd%\gyp;%PATH%

@cd %1
set GYP_MSVS_VERSION=%MSVC_VER%
call gyp.bat -d all --format=msvs --no-circular-check -D win_release_RuntimeLibrary=2 -D win_debug_RuntimeLibrary=2 src\client\windows\breakpad_client.gyp
call gyp.bat -d all --format=msvs --no-circular-check -D win_release_RuntimeLibrary=2 -D win_debug_RuntimeLibrary=2 src\tools\windows\tools_windows.gyp
call gyp.bat -d all --format=msvs --no-circular-check -D win_release_RuntimeLibrary=2 -D win_debug_RuntimeLibrary=2 src\processor\processor.gyp

ECHO ON
for %%C IN (Debug,Release) DO (
  msbuild src\client\windows\handler\exception_handler.vcxproj /p:Configuration=%%C;Platform=%BUILD_ARCH%
  xcopy /Y src\client\windows\handler\%%C\lib\* %2\lib\%%C\

  msbuild src\client\windows\common.vcxproj /p:Configuration=%%C;Platform=%BUILD_ARCH%
  xcopy /Y src\client\windows\%%C\lib\* %2\lib\%%C\

  msbuild src\client\windows\crash_generation\crash_generation_client.vcxproj /p:Configuration=%%C;Platform=%BUILD_ARCH%
  msbuild src\client\windows\crash_generation\crash_generation_server.vcxproj /p:Configuration=%%C;Platform=%BUILD_ARCH%
  xcopy /Y src\client\windows\crash_generation\%%C\lib\* %2\lib\%%C\

  msbuild src\client\windows\sender\crash_report_sender.vcxproj /p:Configuration=%%C;Platform=%BUILD_ARCH%
  xcopy /Y src\client\windows\sender\%%C\lib\* %2\lib\%%C\
)

msbuild src\tools\windows\dump_syms\dump_syms.vcxproj /p:Configuration=Release;Platform=%BUILD_ARCH%
xcopy /Y src\tools\windows\dump_syms\Release\dump_syms.exe %2\bin\

mkdir %2\include

xcopy /Y src\client\*.h %2\include\client\
xcopy /Y /S src\client\windows\*.h %2\include\client\windows\
xcopy /Y /S src\common\*.h %2\include\common\
xcopy /Y /S src\google_breakpad\*.h %2\include\google_breakpad\
xcopy /Y /S src\processor\*.h %2\include\processor\
@endlocal
