#!/bin/bash -e
# Boost
# =====

src_dir=$1
ins_dir=$2

cd src/${src_dir}

if [[ -z "$SKIP_PYTHON" ]]; then
  # Detect Python 3
  BREW_PYTHON=$HOME/.linuxbrew/bin/python3
  if   [[ -e "$BREW_PYTHON" ]];   then PYTHON_EXECUTABLE=$BREW_PYTHON
  elif [[ -e $(which python3) ]]; then PYTHON_EXECUTABLE=$(which python3)
  fi

  if [[ -n "$PYTHON_EXECUTABLE" ]]; then
    echo "Found $PYTHON_EXECUTABLE. Building Boost::Python (and Boost::Numpy if numpy installed)"
    export PYTHON_VERSION=$($PYTHON_EXECUTABLE -c "import sys; print('{}.{}'.format(*sys.version_info))" 2>/dev/null)
    sed -ibak "s,using python.*,using python : $PYTHON_VERSION : $PYTHON_EXECUTABLE \
                                             : $($PYTHON_EXECUTABLE -c 'from __future__ import print_function; import distutils.sysconfig as s; print(s.get_python_inc(True))')\
                                             : $($PYTHON_EXECUTABLE -c 'from __future__ import print_function; import sys; print(sys.prefix)')/lib ;," bootstrap.sh
    WITH_PYTHON=--with-python
    PYTHON_VERSION_STRING="python=$PYTHON_VERSION"
    export PYTHON=$PYTHON_EXECUTABLE
  fi
  # WITH_PYTHON and PYTHON_VERSION_STRING were set if Python 3 was found.
fi

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
