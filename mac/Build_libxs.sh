# Crossroads (libxs)
# ===========================

src_dir=$1
ins_dir=$2
cd src/${src_dir}

export CXXFLAGS="${CXXFLAGS} -DLIBCXX_WORKAROUND=1"
source posix/$(basename $0)
