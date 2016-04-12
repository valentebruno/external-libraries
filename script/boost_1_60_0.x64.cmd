@setlocal
@set root_dir=%CD%
@cd src\%1
@call %VSSETUP_COMMAND%
@call bootstrap.bat
@mkdir %root_dir%\build\%1\build64
@b2 --without-mpi --without-python --build-dir=%root_dir%\build\%1\build64 --prefix=%2\%1\ variant=debug variant=release link=static runtime-link=shared architecture=x86 address-model=64 toolset=msvc-14.0 install
@cd %2\%1\include
@move boost-1_60\boost .
@rmdir boost-1_60
