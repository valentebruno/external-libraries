#!/bin/bash
cd src/$1
cd source

installdir_win=$2
installdir=${installdir_win//\\//}
PATH=/c/git-sdk-64/mingw64/bin:${PATH} #you must have make installed - See git-sdk or Msys, and rename mingw32-make.

./runConfigureICU MSYS/MSVC/Debug --enable-debug --enable-static --disable-shared --prefix=$installdir
make
make install
rm $installdir/lib/sicudtd.dll
make clean
./runConfigureICU MSYS/MSVC/Release --enable-static --disable-shared --prefix=$installdir
make
make install
rm $installdir/lib/sicudt.dll
