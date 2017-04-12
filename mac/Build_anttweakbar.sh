# AntTweakBar [libc++]
# ====================


src_dir=$1
ins_dir=$2
cd src/${src_dir}

make -j 4 -f Makefile.osx
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp -R ../include/* "${ins_dir}/include/"
cp ../lib/libAntTweakBar.dylib "${ins_dir}/lib"
install_name_tool -id @loader_path/libAntTweakBar.dylib "${ins_dir}/lib/libAntTweakBar.dylib"
