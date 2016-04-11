CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
set Path=%Path%;C:\Perl64\bin
perl Configure VC-WIN32 no-asm
call ms\do_nt
nmake -f ms\nt.mak
nmake -f ms\nt.mak install
move C:\usr\local\ssl C:\Libraries-x86_vc14\openssl
rmdir C:\usr\local
rmdir C:\usr
