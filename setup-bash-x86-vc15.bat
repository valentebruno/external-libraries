@echo off
echo Loading VC...
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
"C:\Program Files\Git\bin\bash.exe" --login -i
