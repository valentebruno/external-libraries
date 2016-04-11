CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
set Path=%Path%;C:\Perl64\bin
perl Configure VC-WIN64A
call ms\do_win64a
nmake -f ms\nt.mak
nmake -f ms\nt.mak install
move C:\usr\local\ssl C:\Libraries-x64_vc14\openssl
rmdir C:\usr\local
rmdir C:\usr
