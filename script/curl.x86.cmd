@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

@nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
@mkdir %2\%3
@mkdir %2\%3\include
@mkdir %2\%3\lib
@copy zconf.h %2\%3\include
@copy zlib.h %2\%3\include
@copy zlib.lib %2\%3\lib
@endlocal
