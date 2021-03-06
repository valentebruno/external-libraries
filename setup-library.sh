#!/bin/bash -e

# realpath is not available on macOS
which realpath || realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

if [[ -z "${BUILD_DIR}" ]]; then
  export BUILD_DIR=$(realpath ./src)
fi

function download_git {
  url=$1
  branch=$2
  if [[ $branch == @* ]]; then
    git clone ${url}
    pushd ./${foldername} > /dev/null
    git checkout ${branch:1}
    popd > /dev/null
  else
    git clone ${url} --depth 1 ${branch:+--branch ${branch}}
  fi
}

function download_curl {
  url=$1
  filename=$(basename ${url})

  curl -OL ${url}

  if [[ $OSTYPE == msys* ]]; then
    if [[ ${filename} == *.tar.[gx]z ]] || [[ ${filename} == *.tgz ]]; then
      filebase=${filename%.t[argz\.]*}
      7z x ${filename}
      7z x ${filebase}.tar
      rm -f ${filebase}.tar
    else
      7z x ${filename}
    fi
  else
    if [[ ${filename} =~ .*\.zip ]]; then
      unzip -q ${filename}
    else
      if [[ $OSTYPE != darwin* ]]; then
        tar_arg="--checkpoint=100"
      fi
      tar xf ${filename} ${tar_arg}
    fi
  fi

  rm -f ${filename}
}

function download_lib {
  url=$1
  branch=$2
  foldername=$3
  force_git=$4

  if [[ ${force} == true ]]; then
    rm -rf ${BUILD_DIR}/${foldername}
  fi

  if [[ -e ${BUILD_DIR}/${foldername} ]];  then
    return
  fi

  if [[ ${verbose} ]]; then
    echo "Downloading Library ${foldername}"
  fi

  if [[ ! -d ${BUILD_DIR} ]]; then
    mkdir ${BUILD_DIR}
  fi

  pushd ${BUILD_DIR} > /dev/null

  if [[ ${force_git} == true ]] || [[ ${url} =~ ^git* ]]; then
    download_git ${url} ${branch} ${foldername}
  else
    download_curl ${url}
  fi
  popd > /dev/null

  #Patches are windows only.
  if [[ $OSTYPE == msys* ]]; then
    patch_lib ${source_dir}
  fi
}

function patch_lib {
  name=$1

  patchpath="$(pwd)/patch/${name}.patch"
  if [[ -e  ${patchpath} ]]; then
    patch -i "${patchpath}" -p0 -fsN -d "${BUILD_DIR}/${name}"
  fi

}

function build_lib {
  source_dir=$1
  install_path=$2
  base_name=$3
  version=$4
  if [[ ! -d "${install_path}" ]] || [[ ${force} == true ]]; then
    if [[ ${BUILD_TYPE} == win ]]; then
      install_path=$(cygpath -w $2)
    fi
    
    if [[ ! -f "./${BUILD_TYPE}/${base_name}.sh" ]]; then
      ./posix/${base_name}.sh ${source_dir} ${install_path} ${version}
    else
      ./${BUILD_TYPE}/${base_name}.sh ${source_dir} ${install_path} ${version}
    fi

    if [[ "$?" != "0" ]]; then
      echo "error building ${base_name}, cleaning ${install_path}"
      rm -rf ${install_path}
    fi
  fi
}

function make_check_err {
  make $@
  _err=$?
  if [[ "$_err" != "0" ]]; then
    exit $_err
  fi
}
export -f make_check_err

function build_cmake_lib {
  mkdir -p b
  cd b
  cmake .. ${CMAKE_GENERATOR:+-G"${CMAKE_GENERATOR}"} -DCMAKE_INSTALL_PREFIX:PATH="$1" -DCMAKE_BUILD_TYPE:STRING=Release ${@:2} ${CMAKE_ADDITIONAL_ARGS}

  target_args=""
  if [[ -n ${cmake_build_target} ]]; then
    target_args="--target ${cmake_build_target}"
  fi

  if [[ $VS_VER_YEAR ]]; then
    cmake --build . ${target_args} --config Debug -- ${CMAKE_BUILD_ARGS}
    for f in bin/Debug/*Test{,.exe}; do
      if [ -x $f ]; then
        (cd $(dirname $f) && ./$(basename $f))
      fi
    done
    if [ -z "${target_args}" ]; then
      cmake --build . --target install --config Debug -- ${CMAKE_BUILD_ARGS}
    fi
  fi
  cmake --build . ${target_args} --config Release -- ${CMAKE_BUILD_ARGS}
  
  if [[ "${BUILD_TYPE}" != "android" ]]; then #Don't run tests on android, our build environment isn't setup to run android apps.
    for f in bin/*Test{,.exe} bin/Release/*Test{,.exe}; do
      if [ -x $f ]; then
        (cd $(dirname $f) && ./$(basename $f))
      fi
    done
  fi
  if [ -z "${target_args}" ]; then
    cmake --build . --target install --config Release -- ${CMAKE_BUILD_ARGS}
  fi
}
export -f build_cmake_lib

function is_lib_target {
  local libname=$1
  if [ -z "$LIBRARY_TARGETS" ]; then
    return 0
  fi
  [[ $LIBRARY_TARGETS =~ (^|[[:space:]])$libname($|[[:space:]]) ]] && return 0 || return 1
}

function setup-library {
  local url=$1
  local version=$2
  local install_root=${EXT_LIB_INSTALL_ROOT}
  local source_dir=${url##*/}
  local source_dir=${source_dir%.*}
  local branch=v${version}
  local base_name=${source_dir}
  local output_dir=${source_dir}-${version}

  force=false
  force_git=false

  OPTIND=3

  while getopts ":vfgs:b:o:n:" arg; do
    case $arg in
      s)
        source_dir=${OPTARG}
        ;;
      b)
        branch=${OPTARG}
        ;;
      o)
        output_dir=${OPTARG}
        ;;
      n)
        base_name=${OPTARG}
        ;;
      g)
        force_git="true"
        ;;
      f)
        force="true"
        ;;
      v)
        verbose=true
        ;;
      \?)
        echo "Unknown Option"
        ;;
      esac
  done

  if ! is_lib_target "$base_name"; then
    return 0
  fi

  if [[ ${extract_dir} ]]; then
    extract_dir=${source_dir}
  fi

  if [[ ${verbose} ]]; then
    echo url=${url}
    echo version=${version}
    echo install_root=${EXT_LIB_INSTALL_ROOT}
    echo source_dir=${source_dir}
    echo branch=${branch}
    echo output_dir=${output_dir}
    echo force_git=${force_git}
    echo force=${force}
  fi
  echo "Building ${base_name}"

  download_lib ${url} ${branch} ${source_dir} ${force_git}

  build_lib "${source_dir}" "${install_root}/${output_dir}" "${base_name}" "${version}"

  if [[ $OSTYPE == msys* ]]; then
    export ${base_name^^}_PATH="$(cygpath -w ${install_root}/${output_dir})"
  else
    local varname=$(echo $base_name | tr '[:lower:]' '[:upper:]')_PATH
    export $varname="${install_root}/${output_dir}"
  fi
}
