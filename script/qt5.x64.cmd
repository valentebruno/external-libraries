@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@set PATH=%CD%\src;%PATH%
@cd src\%1

@set PATH=ICU_BIN_PATH;%PATH%
@set PATH=C:\Perl64\bin;%PATH%
@set PATH=C:\Python27-x64;%PATH%
@set PATH=C:\Ruby22-x64\bin;%PATH%
@set PATH=%CD%\qtbase\bin;%CD%\gnuwin32\bin;%PATH%
echo path=%PATH%
rem Uncomment the below line when using a git checkout of the source repository
SET PATH=%CD%\qtrepotools\bin;%PATH%
@set QMAKESPEC=win32-msvc2015

@cd ..
@mkdir build64
@cd build64

@call ..\%1\configure -no-avx2 -no-avx -no-sse4.2 -no-sse4.1 -c++11 -prefix "%2\%3" -opensource ^
-confirm-license -debug-and-release -opengl desktop -no-angle -no-incredibuild-xge ^
-nomake examples -nomake tests -platform win32-msvc2015 -mp -openssl-linked ^
-I "%OPENSSL_PATH%\include" -L "%OPENSSL_PATH%\lib" ^
OPENSSL_LIBS="-lUser32 -lAdvapi32 -lGdi32 -lWs2_32 -lWinmm -lWldap32 -lssleay32MT -llibeay32MT" ^
-no-icu -I "%ICU_PATH%\include" -L "%ICU_PATH%\lib"

@jom
@jom install
@endlocal
