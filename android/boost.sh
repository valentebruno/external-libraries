#!/bin/bash -e
# Boost 1.63
# ===================

user_config=~/user-config.jam
echo "Generating config in $user_config..."
rm -f $user_config
cat <<EOF > $user_config
import os ;
using clang : android :
	${CXX} :
	<archiver>${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}ar
	<ranlib>${CROSS_COMPILER_PATH}/${CROSS_COMPILER_PREFIX}ranlib
	<compileflags>--sysroot=${SYSROOT}
	<compileflags>${CFLAGS}
;
EOF

export boost_additional_args="toolset=clang-android target-os=android"
source posix/$(basename $0)
