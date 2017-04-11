@setlocal
@set root_dir=%CD%
@cd src\%1
SET PERL_ROOT=C:\Perl64\bin
@set Path=%PERL_ROOT%;%Path%

@call %VSSETUP_COMMAND%

SETLOCAL EnableExtensions EnableDelayedExpansion
:: Helpful resources:
:: http://developer.covenanteyes.com/building-openssl-for-visual-studio/
:: https://www.npcglib.org/~stathis/blog/precompiled-openssl/ <- This file mostly copied from here
::
:: ========================================================================================================
:: ==== OpenSSL Library compilation with MSVC
:: ========================================================================================================
::
::      Author: stathis <stathis@npcglib.org>
::    Revision: $Id: build-openssl-1.0.2k.bat 4857 2017-01-27 08:50:25Z stathis $
::
:: Description: This script can be used to compile the OpenSSL Library with MSVC
::              The script builds all (8) permutations of:
::              (x86 | x64) - (static | shared) - (debug | release)
::
::              ATTENTION: Before compiling OpenSSL, you need to patch the sources to enable building
::                         the libraries with different suffixes. (see usage on how to patch)
::
::  Changelog:
::
:: 26/01/2017 - Added compiling of tests and improved logging while building.
::
:: 02/12/2015 - Added some of the OpenSSL info files (e.g. LICENSE, README, etc.)
::
:: 22/10/2015 - Headers of 64-bit and 32-bit builds are now in separate directories (include vs include64)
::              [thanks Paul H.]
::
:: 22/07/2015 - Build log files are now produced during builds.
::
:: 25/10/2013 - Various fixes to enable packaging the required debug symbols for the produced libraries.
::            - Patching has now been migrated to a single patch per release (for the whole source tree)
::
:: 04/03/2013 - created patches for mk1mf.pl, mkdef.pl and util/VC-32.pl to enable different library
::              suffixes, according to the run-time library linked against:
::
::              {libname}MT   -- statically linked release OpenSSL libraries
::              {libname}MTd  -- statically linked debug OpenSSL libraries
::              {libname}MD   -- dynamically linked release OpenSSL libraries
::              {libname}MDd  -- dynamically linked release OpenSSL libraries
::
:: ========================================================================================================
:: ==== <CONFIGURATION>
:: ========================================================================================================
::
:: Set the version of Visual Studio. This will just add a suffix to the string
:: of your directories to avoid mixing them up.
SET VS_VERSION=!MSVC_VER!

rem ========================================================================================================

rem ========================================================================================================

:: Set this to the name of the project
SET BUILD_PROJECT=openssl

:: Set this to the version of the project you are building
SET PROJECT_VERSION=1.0.2k

:: SET PROJECT_SRC_DIR=D:\opensource\!BUILD_PROJECT!-!PROJECT_VERSION!
SET PROJECT_SRC_DIR=%cd%

SET PROJECT_INSTALL_DIR=%2

rem ========================================================================================================
rem == PLEASE DO NOT EDIT BELOW THIS LINE
rem ========================================================================================================

rem We load the config file first
call :loadconfig "%~dpn0"

rem we then carry on execution
call :execScript %0 %1 %2 %3 %4

ENDLOCAL

@exit /B 0

rem ========================================================================================================
rem == Pseudo-function to load config
rem ========================================================================================================

:loadconfig
rem set the variable HOSTNAME by executing the command (that's the computer's name)
FOR /F "delims=" %%a IN ('hostname') DO @set HOSTNAME=%%a

rem strip double quotes
set scriptFile=%1
set scriptFile=%scriptFile:"=%

rem We use two files: myScript.conf and myScript.<HOSTNAME>
rem myScript.<HOSTNAME> overrides myScript.conf
rem %~dpn0 is the full file minus the extension.
FOR %%c IN (
  "!scriptFile!.conf"
  "!scriptFile!.!HOSTNAME!"
) DO (
  IF EXIST "%%c" (
    ECHO.
    ECHO # Loading local configuration from: %%c
    ECHO.
    FOR /F "usebackq delims=" %%v IN (%%c) DO (set %%v)
  )
)

GOTO :eof

rem ========================================================================================================

:execScript
rem Use this pseudo-function to write the code of your main script
SETLOCAL EnableExtensions EnableDelayedExpansion

SET scriptName=%1
SET arg[0]=%2
SET arg[1]=%3
SET arg[2]=%4
SET arg[3]=%5

:: ATTENTION: this is down here because out-of-source builds are not supported DO NOT CHANGE IT!
SET PROJECT_BUILD_DIR=!PROJECT_SRC_DIR!\build

IF NOT EXIST "!PROJECT_SRC_DIR!" (
  ECHO.
  CALL :exitB "ERROR: Source directory !PROJECT_SRC_DIR! does not exist or does not contain the !BUILD_PROJECT! sources. Aborting."
  GOTO :eof
)

call :buildall
ENDLOCAL
GOTO :eof

rem ========================================================================================================
:printConfiguration
SETLOCAL EnableExtensions EnableDelayedExpansion

echo.
echo                    PATH: !PATH!
echo.

echo              VS_VERSION: !VS_VERSION!
echo        VISUAL_STUDIO_VC: !VISUAL_STUDIO_VC!
echo.
echo           BUILD_PROJECT: !BUILD_PROJECT!
echo         PROJECT_VERSION: !PROJECT_VERSION!
echo         PROJECT_SRC_DIR: !PROJECT_SRC_DIR!
echo       PROJECT_BUILD_DIR: !PROJECT_BUILD_DIR!
echo     PROJECT_INSTALL_DIR: !PROJECT_INSTALL_DIR!
ENDLOCAL
goto :eof

rem ========================================================================================================

:usage
call :printConfiguration
ECHO:
ECHO Error in script usage. The correct usage is:
ECHO:
ECHO     !scriptName! [patch^|unpatch] - apply/remove patches to the sources
ECHO     !scriptName! build [all^|x86^|x64] ^<[static^|shared] [debug^|release]^> - builds all or specific permutations
ECHO     !scriptName! package [all^|x86^|x64] ^<[static^|shared]^> - creates a package file
ECHO:
GOTO :eof

rem ========================================================================================================

:: %1 library type (e.g. static)
:packagetype

SET DST_DIST=!BUILD_PROJECT!-!PROJECT_VERSION!-vs!VS_VERSION!
SET DST_DIST_DIR=!PROJECT_INSTALL_DIR!

for %%l in (static shared) do (
  for %%a in (x86 x64) do (

    if /i "%%a" == "x86" (
      SET BITS=32
      SET BITSTR=
    ) else (
      SET BITS=64
      SET BITSTR=!BITS!
      SET PREFIX_WIN=!PREFIX_WIN!!BITS!
    )

    for %%b in (debug release) do (

      SET __ARCH=%%a
      SET __BUILD=%%b
      SET __LINK=%%l

      SET SRC_DIST_DIR=!PROJECT_INSTALL_DIR!\!BUILD_PROJECT!-!__ARCH!-!__LINK!-!__BUILD!-vs!VS_VERSION!

      echo [copy] !SRC_DIST_DIR! =^> !DST_DIST_DIR!

      if exist "!SRC_DIST_DIR!" (

        xcopy /E /Q /Y !SRC_DIST_DIR!\bin\*.* !DST_DIST_DIR!\bin!BITSTR!\
        xcopy /E /Q /Y !SRC_DIST_DIR!\lib\*.* !DST_DIST_DIR!\lib!BITSTR!\
        xcopy /E /Q /Y !SRC_DIST_DIR!\include\*.* !DST_DIST_DIR!\include!BITSTR!\
        xcopy /E /Q /Y !SRC_DIST_DIR!\ssl\*.* !DST_DIST_DIR!\ssl\

      )

    )
  )
)

echo Copied all files for: !BUILD_PROJECT! v!PROJECT_VERSION!

set README=!DST_DIST_DIR!\readme.precompiled.txt
echo !README!

pushd !PROJECT_INSTALL_DIR!

  SETLOCAL EnableExtensions EnableDelayedExpansion

  echo ------------------------------------------------------------------------------ >> !README!
  echo 32-bit OpenSSL Libraries [static] [runtime: dynamic (/MD)]]>> !README!
  echo ------------------------------------------------------------------------------ >> !README!
  echo         release libs: lib\libeay32MD.lib lib\ssleay32MD.lib >> !README!
  echo           debug libs: lib\libeay32MDd.lib lib\ssleay32MDd.lib >> !README!
  echo. >> !README!

  bash -c "cp -f \"!PROJECT_SRC_DIR!\CHANGES\" \"!DST_DIST_DIR!\CHANGES.txt\""
  bash -c "cp -f \"!PROJECT_SRC_DIR!\README\" \"!DST_DIST_DIR!\README.txt\""
  bash -c "cp -f \"!PROJECT_SRC_DIR!\NEWS\" \"!DST_DIST_DIR!\NEWS.txt\""
  bash -c "cp -f \"!PROJECT_SRC_DIR!\LICENSE\" \"!DST_DIST_DIR!\LICENSE.txt\""

  set __FILENAME=!DST_DIST!

  ENDLOCAL

popd

goto :eof

rem ========================================================================================================

:buildall

rem IF NOT EXIST "!PERL_ROOT!\perlenv.bat" (
rem   ECHO.
rem   call :exitB "Make sure !PERL_ROOT! points to a valid Perl root directory. (perlenv.bat is missing)"
rem   goto :eof
rem )

rem call !PERL_ROOT!\perlenv.bat

for %%b in (debug release) do (
  call :build %BUILD_ARCH% static %%b
)

goto :eof

rem ========================================================================================================

:: call :build <x86|x64> <static|shared> <debug|release>
:build
SET __ARCH=%~1
SET __LINK=%~2
SET __BUILD=%~3

if /i "!__ARCH!" == "x86" (
  SET BITS=32
  SET BIT_STR=
) else (
  SET BITS=64
  SET BIT_STR=64
)

echo:
echo Building OpenSSL Library [!__ARCH!] [!__LINK!] [!__BUILD!]
echo:

SETLOCAL EnableExtensions EnableDelayedExpansion

  call :printConfiguration
  call :buildtype !__ARCH! !__LINK! !__BUILD!

ENDLOCAL
goto :eof


rem ========================================================================================================

:: call :build <x86|x64> <static|shared> <debug|release>
:buildtype
SET __ARCH=%~1
SET __LINK=%~2
SET __BUILD=%~3

if /i "!__ARCH!" == "x86" (
  SET BITS=32
  SET BIT_STR=
) else (
  SET BITS=64
  SET BIT_STR=64
)

IF NOT EXIST "!PROJECT_BUILD_DIR!" (
  mkdir "!PROJECT_BUILD_DIR!"
)

SET RUNTIME_SUFFIX=MD

SET LIBSUFFIX=
if /i "!__BUILD!" == "debug" (
  SET LIBSUFFIX=d
)

SET RUNTIME_FULL_SUFFIX=!RUNTIME_SUFFIX!!LIBSUFFIX!

SET B_CMD=perl Configure
SET COMMON_OPTIONS=enable-static-engine
SET MODE=VC-WIN

if /i "!__BUILD!" == "debug" (
  SET MODE=!__BUILD!-!MODE!
)

if /i "!__ARCH!" == "x86" (
  SET MODE=!MODE!!BITS!
  rem SET MS_CMD=call ms\do_nasm.bat

  SET COMMON_OPTIONS=!COMMON_OPTIONS! no-asm
) else (
  SET MODE=!MODE!!BITS!A
  rem SET MS_CMD=call ms\do_win64a.bat
)

SET INSTALL_DIR=!PROJECT_INSTALL_DIR!

IF NOT EXIST "!INSTALL_DIR!" (
  mkdir "!INSTALL_DIR!"
)

SET CONFIG_LOG_FILE=!INSTALL_DIR!\!BUILD_PROJECT!-!__ARCH!-!__LINK!-!__BUILD!-vs!VS_VERSION!.config.log
SET BUILD_LOG_FILE=!INSTALL_DIR!\!BUILD_PROJECT!-!__ARCH!-!__LINK!-!__BUILD!-vs!VS_VERSION!.build.log
SET TEST_LOG_FILE=!INSTALL_DIR!\!BUILD_PROJECT!-!__ARCH!-!__LINK!-!__BUILD!-vs!VS_VERSION!.test.log
SET INSTALL_LOG_FILE=!INSTALL_DIR!\!BUILD_PROJECT!-!__ARCH!-!__LINK!-!__BUILD!-vs!VS_VERSION!.install.log

ECHO. > !CONFIG_LOG_FILE!

SET B_CMD=!B_CMD! !MODE! !COMMON_OPTIONS! --prefix=!INSTALL_DIR!

echo Commands: !B_CMD!
rem echo Commands: !MS_CMD!
rem echo Commands: !MK_CMD!

pushd !PROJECT_SRC_DIR!
!B_CMD! > !CONFIG_LOG_FILE! 2>&1

SET BUILD_STR_PLAIN=
if /i "!__BUILD!" == "debug" (
  SET BUILD_STR_PLAIN=debug
)

SET BUILD_STR=
if /i "!__BUILD!" == "debug" (
  SET BUILD_STR=debug_lib
)

perl util\mkfiles.pl >MINFO

if /i "!__ARCH!" == "x86" (

  echo "perl util\mk1mf.pl !BUILD_STR_PLAIN! !BUILD_STR! !LINK_STR! nasm VC-WIN32 >ms\nt-!__ARCH!.mak"
  perl util\mk1mf.pl !BUILD_STR_PLAIN! !BUILD_STR! !LINK_STR! nasm VC-WIN32 >ms\nt-!__ARCH!.mak

) else (

  perl ms\uplink-x86_64.pl masm > ms\uptable.asm
  ml64 -c -Foms\uptable.obj ms\uptable.asm

  rem perl ms\uplink-x86_64.pl nasm > ms\uptable.asm
  rem nasm -f win64 -o ms\uptable.obj ms\uptable.asm

  echo "perl util\mk1mf.pl !BUILD_STR_PLAIN! !BUILD_STR! !LINK_STR! VC-WIN64A >ms\nt-!__ARCH!.mak"
  perl util\mk1mf.pl !BUILD_STR_PLAIN! !BUILD_STR! !LINK_STR! VC-WIN64A >ms\nt-!__ARCH!.mak

)

echo "perl util\mkdef.pl !BUILD_STR! !LINK_STR! 32 libeay > ms\libeay32!RUNTIME_FULL_SUFFIX!.def"
perl util\mkdef.pl !BUILD_STR! !LINK_STR! 32 libeay > ms\libeay32!RUNTIME_FULL_SUFFIX!.def

echo "perl util\mkdef.pl !BUILD_STR! !LINK_STR! 32 ssleay > ms\ssleay32!RUNTIME_FULL_SUFFIX!.def"
perl util\mkdef.pl !BUILD_STR! !LINK_STR! 32 ssleay > ms\ssleay32!RUNTIME_FULL_SUFFIX!.def


SET MK_CMD=nmake -f ms\nt-!__ARCH!.mak

ECHO. > !BUILD_LOG_FILE!

!MK_CMD! > !BUILD_LOG_FILE! 2>&1

!MK_CMD! test >> !TEST_LOG_FILE! 2>&1

!MK_CMD! install >> !INSTALL_LOG_FILE! 2>&1


rem There is debug symbols produced in this library for both Debug and Release libraries. We keep it all :)
if /i "!__BUILD!" == "debug" (
  SET TMPDIR_SUFFIX=.dbg
) ELSE (
  SET TMPDIR_SUFFIX=
)

copy /Y out32!TMPDIR_SUFFIX!\openssl!RUNTIME_FULL_SUFFIX!.pdb !INSTALL_DIR!\bin\

if /i "!__LINK!" == "shared" (
  copy /Y out32!TMPDIR_SUFFIX!\libeay32!RUNTIME_FULL_SUFFIX!.pdb !INSTALL_DIR!\bin\
  copy /Y out32!TMPDIR_SUFFIX!\ssleay32!RUNTIME_FULL_SUFFIX!.pdb !INSTALL_DIR!\bin\

  copy /Y out32!TMPDIR_SUFFIX!\libeay32!RUNTIME_FULL_SUFFIX!.exp !INSTALL_DIR!\lib\
  copy /Y out32!TMPDIR_SUFFIX!\ssleay32!RUNTIME_FULL_SUFFIX!.exp !INSTALL_DIR!\lib\
)

rem The following two are debug symbols that will be searched for when linking against the .lib files from client applications
rem That's why they are placed in the lib/ folder.
rem For some reason the appXX.pdb and libXX.pdb files are lower case (?)
copy /Y tmp32!TMPDIR_SUFFIX!\app!RUNTIME_FULL_SUFFIX!.pdb !INSTALL_DIR!\lib\app!RUNTIME_FULL_SUFFIX!.pdb
copy /Y tmp32!TMPDIR_SUFFIX!\lib!RUNTIME_FULL_SUFFIX!.pdb !INSTALL_DIR!\lib\lib!RUNTIME_FULL_SUFFIX!.pdb

rem This is necessary for building on different architectures. (there are conf files being left behind)
!MK_CMD! vclean

popd

goto :eof

rem ========================================================================================================

:toLower str -- converts uppercase character to lowercase
::           -- str [in,out] - valref of string variable to be converted
:$created 20060101 :$changed 20080219 :$categories StringManipulation
:$source http://www.dostips.com
if not defined %~1 EXIT /b
for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i"
            "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r"
            "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z" "Ä=ä"
            "Ö=ö" "Ü=ü") do (
    call set %~1=%%%~1:%%~a%%
)
EXIT /b

rem ========================================================================================================

:: %1 an error message
:exitB
echo:
echo Error: %1
echo:
echo Contact stathis@npcglib.org
@exit /B 0
