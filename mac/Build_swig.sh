# SWIG
# ====

SWIG_VERSION=3.0.8
PCRE_VERSION=8.38

if [ ! -f swig-${SWIG_VERSION}.tar.gz ]; then
  curl -O "http://iweb.dl.sourceforge.net/project/swig/swig/swig-${SWIG_VERSION}/swig-${SWIG_VERSION}.tar.gz"
fi
if [ ! -f pcre-${PCRE_VERSION}.tar.bz2 ]; then
  curl -O "http://iweb.dl.sourceforge.net/project/pcre/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.bz2"
fi

rm -fr swig-${SWIG_VERSION}
tar xfz "swig-${SWIG_VERSION}.tar.gz"
cd swig-${SWIG_VERSION}
tar xfj "../pcre-${PCRE_VERSION}.tar.bz2"
cd pcre-${PCRE_VERSION}
./configure --enable-shared=no --prefix="`pwd`/../pcre"
make -j 4 && make install
cd ..
./configure --with-pcre --with-pcre-prefix="`pwd`/pcre" --prefix="${EXTERNAL_LIBRARY_DIR}/swig-3.0.8" --with-boost="${EXTERNAL_LIBRARY_DIR}/boost_${BOOST_VERSION}-libc++"
make -j 4 && make install
cd ..
