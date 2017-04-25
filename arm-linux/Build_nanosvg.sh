# nanosvg
# =======

src_dir=$1
ins_dir=$2
cd src/${src_dir}

mkdir -p ${ins_dir}/include
cp src/*.h ${ins_dir}/include/
cp LICENSE.txt ${ins_dir}/
