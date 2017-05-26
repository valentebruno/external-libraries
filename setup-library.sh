#!/bin/bash
function download_git {
  url=$1
  branch=$2
  src_dir=$3
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
      tar xfz ${filename} ${tar_arg}
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
    rm -rf src/${foldername}
  fi

  if [[ -e src/${foldername} ]];  then
    return
  fi

  if [[ ${verbose} ]]; then
    echo "Downloading Library ${foldername}"
  fi

  if [[ ! -d src ]]; then
    mkdir src
  fi

  pushd src > /dev/null

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
    patch -i "${patchpath}" -p0 -fsN -d "$(pwd)/src/${name}"
  fi

}

function build_lib_win {
  source_dir=$1
  install_path=$2
  base_name=$3

  install_path_win=$(cygpath -w $2)
  if [[ ! -d "${install_path}" ]] || [[ ${force} == true ]]; then
    if [[ ! -f "./win/${base_name}.sh" ]]; then
      ./posix/Build_${base_name}.sh ${source_dir} ${install_path_win}
    else
      ./win/${base_name}.sh ${source_dir} ${install_path_win}
    fi
  fi
}

function build_lib_posix {
  source_dir=$1
  install_path=$2
  base_name=$3

  if [[ ! -d "${install_path}" ]] || [[ ${force} == true ]]; then
    if [[ ! -f "./${BUILD_TYPE}/Build_${base_name}.sh" ]]; then
      ./posix/Build_${base_name}.sh ${source_dir} ${install_path}
    else
      ./${BUILD_TYPE}/Build_${base_name}.sh ${source_dir} ${install_path}
    fi
  fi
}

function build_cmake_lib {
  mkdir -p b
  cd b
  cmake .. ${CMAKE_GENERATOR:+-G"${CMAKE_GENERATOR}"} -DCMAKE_INSTALL_PREFIX:PATH="$1" -DCMAKE_BUILD_TYPE:STRING=Release ${@:2} ${CMAKE_ADDITIONAL_ARGS}

  if [[ $VS_VER_YEAR ]]; then
    cmake --build . --target install --config Debug -- ${CMAKE_BUILD_ARGS}
  fi
  cmake --build . --target install --config Release -- ${CMAKE_BUILD_ARGS}
}
export -f build_cmake_lib

function build_lib {
  if [[ $OSTYPE == msys* ]]; then
    build_lib_win $1 $2 $3
  else
    build_lib_posix $1 $2 $3
  fi
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

  build_lib ${source_dir} "${install_root}/${output_dir}" ${base_name}

  if [[ $OSTYPE == msys* ]]; then
    export ${base_name^^}_PATH="$(cygpath -w ${install_root}/${output_dir})"
  else
    local varname=$(echo $base_name | tr '[:lower:]' '[:upper:]')_PATH
    export $varname="${install_root}/${output_dir}"
  fi
}
