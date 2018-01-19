#!/bin/bash -e
# nss
# ===

src_dir=$1
ins_dir=$2
cd ${BUILD_DIR}/${src_dir}

if [[ $BUILD_ARCH == x64 ]]; then
  OPTS="USE_64=1"
fi

cd nss
export C_INCLUDE_PATH=${ZLIB_PATH}/include
export LIBRARY_PATH=${ZLIB_PATH}/lib
make nss_build_all BUILD_OPT=1 VERBOSE=1 NSS_ENABLE_WERROR=0 ${OPTS}
cd ../dist

NSS_OBJDIR=$(basename $(find . -name "*OPT\.OBJ"))
NSS_INSTALL=${ins_dir}

mkdir -p ${NSS_INSTALL}/lib
install -v -m 644 ${NSS_OBJDIR}/lib/*.a ${NSS_INSTALL}/lib || true
install -v -m 644 ${NSS_OBJDIR}/lib/*.lib ${NSS_INSTALL}/lib || true

mkdir -p ${NSS_INSTALL}/include/nss
cp -v -RL {public,private}/nss/* ${NSS_INSTALL}/include/nss
cp ${NSS_OBJDIR}/include/prcpucfg.h ${NSS_INSTALL}/include/nss
chmod -v 644 ${NSS_INSTALL}/include/nss/*
mkdir -p ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_OBJDIR}/bin/{certutil,pk12util} ${NSS_INSTALL}/bin
install -v -m 755 ${NSS_OBJDIR}/lib/*.so ${NSS_INSTALL}/bin || true
install -v -m 755 ${NSS_OBJDIR}/lib/*.dylib ${NSS_INSTALL}/bin || true
install -v -m 755 ${NSS_OBJDIR}/lib/*.{dll,chk} ${NSS_INSTALL}/bin || true

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
