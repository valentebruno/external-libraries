# glew
# ====

src_dir=$1
ins_dir=$2
cd src/${src_dir}

GLEW_DEST="${ins_dir}" make CC=aarch64-linux-gnu-gcc LD=aarch64-linux-gnu-gcc \
CFLAGS.EXTRA=-fPIC STRIP=aarch64-linux-gnu-strip install
