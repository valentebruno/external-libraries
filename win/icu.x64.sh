#!/bin/bash
cd src/$1
cd source

installdir_win=$2
installdir=$(cygpath -u ${installdir_win})
PATH=/c/git-sdk-64/mingw64/bin:${PATH} #you must have make installed - See git-sdk or Msys, and rename mingw32-make.

#Fix cases where the path to sh is in Program Files
for file in $(find . -name "*.in")
do
  sed -i -e 's/ $(SHELL) / "$(SHELL)" /g' "$file"
done

./runConfigureICU MSYS/MSVC --enable-debug --enable-static --disable-shared --prefix="$installdir"
make
make install

make clean
./runConfigureICU MSYS/MSVC --enable-static --disable-shared --prefix="$installdir"
make
make install
