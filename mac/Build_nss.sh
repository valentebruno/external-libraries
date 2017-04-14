# nss
# ===

src_dir=$1
ins_dir=$2
cd src/${src_dir}

cd nss
make nss_build_all BUILD_OPT=1 USE_64=1 VERBOSE=1
cd ../dist

NSS_BASE=Darwin`uname -r`
NSS_X64=${NSS_BASE}_cc_64_OPT.OBJ
NSS_INSTALL=${ins_dir}

mkdir -p ${NSS_INSTALL}/lib
install -v -m 644 ${NSS_X64}/lib/*.a ${NSS_INSTALL}/lib

mkdir -p ${NSS_INSTALL}/include/nss
cp -v -RL {public,private}/nss/* ${NSS_INSTALL}/include/nss
cp ${NSS_X64}/include/prcpucfg.h ${NSS_INSTALL}/include/nss
chmod -v 644 ${NSS_INSTALL}/include/nss/*
mkdir -p ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_X64}/bin/{certutil,pk12util} ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_X64}/lib/*.dylib ${NSS_INSTALL}/bin

cd ../nspr
mkdir -p ${NSS_INSTALL}/include/nspr/obsolete
mkdir -p ${NSS_INSTALL}/include/nspr/private
cp -v -RL pr/include/*.h ${NSS_INSTALL}/include/nspr
cp -v -RL pr/include/obsolete/*.h ${NSS_INSTALL}/include/nspr/obsolete
cp -v -RL pr/include/private/*.h ${NSS_INSTALL}/include/nspr/private
cp -v -RL lib/ds/*.h ${NSS_INSTALL}/include/nspr
cp -v -RL lib/libc/include/*.h ${NSS_INSTALL}/include/nspr
chmod -v 644 ${NSS_INSTALL}/include/nspr/*.h
chmod -v 644 ${NSS_INSTALL}/include/nspr/*/*.h
