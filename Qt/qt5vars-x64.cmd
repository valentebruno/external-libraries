CALL "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64
SET _ROOT=C:\Qt\Qt-5.5.0
SET PATH=C:\Libraries-x64_vc12\icu-55.1\bin;%PATH%
SET PATH=C:\Perl64\bin;%PATH%
SET PATH=C:\Python27-x64;%PATH%
SET PATH=C:\Ruby22-x64\bin;%PATH%
SET PATH=%_ROOT%\qtbase\bin;%_ROOT%\gnuwin32\bin;%PATH%
REM Uncomment the below line when using a git checkout of the source repository
REM SET PATH=%_ROOT%\qtrepotools\bin;%PATH%
SET QMAKESPEC=win32-msvc2013
SET _ROOT=
