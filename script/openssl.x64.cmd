@setlocal
@set root_dir=%CD%
echo %1 %2
@cd src\%1
@set Path=C:\Perl64\bin;%Path%
@call %VSSETUP_COMMAND%
@perl Configure VC-WIN64A
@call ms\do_win64a.bat
@nmake -f ms\nt.mak
@nmake -f ms\nt.mak install
@move C:\usr\local\ssl %2\%3
@rmdir C:\usr\local
@rmdir C:\usr
@endlocal
