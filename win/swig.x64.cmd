@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src

xcopy /S /I %1 %2
@endlocal
