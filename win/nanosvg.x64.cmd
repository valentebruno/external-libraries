@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1\

mkdir %2\include
xcopy /i src\* %2\include
