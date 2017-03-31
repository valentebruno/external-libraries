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
@set QMAKESPEC=win32-msvc%MSVC_VER%
@cd ..\..
@mkdir build
@cd build
@mkdir qt
@cd qt
@call ..\..\src\%1\configure -no-avx2 -no-avx -no-sse4.2 -no-sse4.1 -c++11 -prefix "%2" -opensource ^
-confirm-license -debug-and-release -opengl desktop -no-angle -no-incredibuild-xge ^
-platform %QMAKESPEC% -mp -openssl-linked -nomake examples -nomake tests -no-icu -no-dbus ^
-skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcanvas3d ^
-skip qtconnectivity -skip qtdeclarative -skip qtdoc -skip qtdocgallery ^
-skip qtenginio -skip qtfeedback -skip qtgraphicaleffects -skip qtimageformats ^
-skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtpim -skip qtpurchasing ^
-skip qtquick1 -skip qtquickcontrols -skip qtquickcontrols2 -skip qtrepotools ^
-skip script -skip qtsensors -skip qtserialbus -skip qtserialport -skip qtsvg ^
-skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebkit ^
-skip qtwebkit-examples -skip qtx11extras -skip qtxmlpatterns ^
-I "%OPENSSL_PATH%\include" -L "%OPENSSL_PATH%\lib" ^
OPENSSL_LIBS="-lUser32 -lAdvapi32 -lGdi32 -lWs2_32 -lWinmm -lWldap32 -lssleay32MT -llibeay32MT" ^
-no-icu

@call bash "../../script/get-jom.sh" %CD%

@jom
@jom install
@endlocal
