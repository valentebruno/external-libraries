# ICU
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd source
./configure --prefix=${ins_dir} && make -j8 && make -j8 install
