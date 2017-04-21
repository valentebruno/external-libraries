@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

mkdir build
cd build

mkdir %2

cl /D_DEBUG /EHsc /MDd /c ..\src\polypartition.cpp
lib polypartition.obj
xcopy /i polypartition.lib %2\lib\debug\

cl /EHsc /MD /c ..\src\polypartition.cpp
lib polypartition.obj
xcopy /i polypartition.lib %2\lib\release\
xcopy /i ..\src\polypartition.h %2\include\

@endlocal
