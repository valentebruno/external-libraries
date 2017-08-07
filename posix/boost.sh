#!/bin/bash -e
# Boost
# =====

src_dir=$1
ins_dir=$2

# Detect Python 3
brew_python=$home/.linuxbrew/bin/python3
if   [[ -e "$brew_python" ]];   then PYTHON_EXECUTABLE=$brew_python
elif [[ -e $(which python3) ]]; then PYTHON_EXECUTABLE=$(which python3)
fi
if [[ -n "$PYTHON_EXECUTABLE" ]]; then
  PYTHON_VERSION=$($PYTHON_EXECUTABLE -c "import sys; print('{}.{}'.format(*sys.version_info))" 2>/dev/null)
  sed -ibak "s,using python.*,using python : $PYTHON_VERSION : $PYTHON_EXECUTABLE
                                           : $($PYTHON -c 'from __future__ import print_function; import distutils.sysconfig as s; print(s.get_python_inc(True))')
                                           : $($PYTHON -c 'from __future__ import print_function; import sys; print(sys.prefix)')/lib ;," bootstrap.sh
  WITH_PYTHON=--with-python
  PYTHON_VERSION_STRING="python=$PYTHON_VERSION"
fi
# WITH_PYTHON and PYTHON_VERSION_STRING were set if Python 3 was found.

cd src/${src_dir}

rm -fr /tmp/$USER/boost

if [[ ! -x ./b2 ]]; then
  ./bootstrap.sh ${boost_toolset}
fi

mkdir -p ${ins_dir}

if [[ -n ${boost_compiler_patch} ]]; then
  sed -i "${boost_compiler_patch}" project-config.jam
fi

./b2 --prefix="${ins_dir}" --build-dir=/tmp/$USER/build-boost $PYTHON_VERSION_STRING $WITH_PYTHON --with-atomic --with-chrono --with-date_time --with-filesystem \
     --with-locale --with-program_options --with-thread --with-regex \
     link=static threading=multi variant=release ${CFLAGS:+cflags="${CFLAGS}"} ${CXXFLAGS:+cxxflags="${CXXFLAGS}"} ${boost_additional_args} install
