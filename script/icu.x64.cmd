@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@SET PATH=C:\Perl64\bin;%PATH%
@SET PATH=C:\Python27-x64;%PATH%
@SET PATH=C:\Ruby22-x64\bin;%PATH%
@call bash "script/icu.x64.sh" %1 %2 %3
@endlocal
