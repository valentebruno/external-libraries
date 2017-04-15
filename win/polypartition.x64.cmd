@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

mkdir build
cd build

cl /EHsc /c ..\src\polypartition.cpp
lib polypartition.obj

mkdir %2
xcopy /i polypartition.lib %2\lib\debug\
xcopy /i polypartition.lib %2\lib\release\
xcopy /i ..\src\polypartition.h %2\include\

@endlocal
