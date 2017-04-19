@setlocal
@set root_dir=%CD%
@call %VSSETUP_COMMAND%
@cd src\%1

if "%MSVC_VER%"=="2015" (
  set CMAKE_GEN=Visual Studio 14 2015
)
if "%MSVC_VER%"=="2013" (
  set CMAKE_GEN=Visual Studio 12 2013
)
if "%BUILD_ARCH%"=="x64" (
  set CMAKE_GEN=%CMAKE_GEN% Win64
)

mkdir build
cd build

call %CMAKE_COMMAND% .. -G"%CMAKE_GEN%" -DCMAKE_INSTALL_PREFIX=%2 ^
-DBUILD_DOCS:BOOL=OFF -DBUILD_PERF_TESTS:BOOL=OFF ^
-DBUILD_TESTS:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=Release ^
-DEIGEN_INCLUDE_PATH:PATH="%EIGEN_PATH%" ^
-DWITH_CUDA:BOOL=OFF -DWITH_QT:BOOL=OFF -DWITH_WEBP:BOOL=OFF -DWITH_OPENCL:BOOL=OFF ^
-DWITH_MATLAB:BOOL=OFF -DENABLE_SSE41:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=OFF
call %CMAKE_COMMAND% --build . --target install --config debug
call %CMAKE_COMMAND% --build . --target install --config release
@endlocal