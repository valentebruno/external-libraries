 # AntTweakBar
 # ====================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd src
make -j 4 CC=${CC} CXX=${CXX} LINK=${CC} CXXCFG="-O3 -fpermissive" ${make_args}
mkdir -p "${ins_dir}/include"
mkdir -p "${ins_dir}/lib"
cp -R ../include/* "${ins_dir}/include/"
cp ../lib/libAntTweakBar.a "${ins_dir}/lib"
