#!/bin/bash -e
# Boost 1.63
# ===================
src_dir=$1
ins_dir=$2

BREW_PYTHON=$HOME/.linuxbrew/bin/python3
export PYTHON=python3
[[ -e "$BREW_PYTHON" ]] && export PYTHON=$BREW_PYTHON
export PYTHON_VERSION=$($PYTHON -c "import sys; print('{}.{}'.format(*sys.version_info))")

cd src/${src_dir}

rm -fr /tmp/$USER/boost

if [[ ! -x ./b2 ]]; then
  sed -ibak "s,using python.*,using python : $PYTHON_VERSION : $(which $PYTHON) : $($PYTHON -c 'from __future__ import print_function; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc(True))') : $($PYTHON -c 'from __future__ import print_function; import sys; print(sys.prefix)')/lib ;," bootstrap.sh
  ./bootstrap.sh ${boost_toolset}
fi

mkdir -p ${ins_dir}

if [[ -n ${boost_compiler_patch} ]]; then
  sed -i "${boost_compiler_patch}" project-config.jam
fi

./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/build-boost python=$PYTHON_VERSION --with-python --with-atomic --with-chrono --with-date_time --with-filesystem \
     --with-locale --with-program_options --with-thread --with-regex \
     link=static threading=multi variant=release ${CFLAGS:+cflags="${CFLAGS}"} ${CXXFLAGS:+cxxflags="${CXXFLAGS}"} ${boost_additional_args} install
