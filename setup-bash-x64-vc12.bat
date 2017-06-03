@echo off
echo Loading VC...
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64
"C:\Program Files\Git\bin\bash.exe" --login -i
