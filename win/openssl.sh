#!/bin/bash

source_dir=${BUILD_DIR}/$1
install_dir=$2

cd ${source_dir}

if [[ $BUILD_ARCH == x64 ]]; then
  export OPENSSL_OS=VC-WIN64A

  build_bat="ms/do_win64a"
else
  export OPENSSL_OS=VC-WIN32
  build_bat="ms/do_ms"
fi

#http://developer.covenanteyes.com/building-openssl-for-visual-studio/

#use ActivePerl or things will get wierd
export PATH="/c/Perl64/bin:${PATH}"

perl Configure debug-${OPENSSL_OS} --prefix="${install_dir}"
${build_bat}.bat
if [[ $BUILD_ARCH == x86 ]]; then
  ms/do_nasm.bat
fi

sed -i 's/\/Zi \/Fd/\/Z7 \/Fd/g' ms/nt.mak
nmake -f ms\\nt.mak
nmake -f ms\\nt.mak install

mv ${install_dir}/lib/libeay32MD.lib ${install_dir}/lib/libeay32MDd.lib
mv ${install_dir}/lib/ssleay32MD.lib ${install_dir}/lib/ssleay32MDd.lib

./Configure ${OPENSSL_OS} --prefix="${install_dir}"
${build_bat}.bat
if [[ $BUILD_ARCH == x86 ]]; then
  ms/do_nasm.bat
fi
nmake -f ms\\nt.mak
nmake -f ms\\nt.mak install
