#!/bin/bash -e
# FreeImage
# =========

src_dir=$1
ins_dir=$2
cd src/${src_dir}

curl -O https://raw.githubusercontent.com/sol-prog/FreeImage-OSX/master/Makefile.osx
sed -i.bak '/^COMPILERFLAGS = / s/$/ -D__ANSI__ -DDISABLE_PERF_MEASUREMENT/' Makefile.osx
sed -i.bak 's/MacOSX10\.8\.sdk/MacOSX10\.12\.sdk/g' Makefile.osx
sed -i.bak 's:^PREFIX = .*:PREFIX = ${ins_dir}' Makefile.osx
sed -i.bak 's/-o root -g wheel //g' Makefile.osx
sed -i.bak 's/^FreeImage: $(STATICLIB) $(SHAREDLIB)/FreeImage: $(STATICLIB)/' Makefile.osx
sed -i.bak 's/install -m 644 $(SHAREDLIB) /install -m 644 /' Makefile.osx
sed -i.bak '/cp \*\.dylib Dist/d' Makefile.osx
sed -i.bak '/ln -sf $(SHAREDLIB) $(INSTALLDIR)\/$(LIBNAME)/d' Makefile.osx
rm -f Makefile.osx.bak
make -f Makefile.osx -j 4 && make -f Makefile.osx install
cd ..
