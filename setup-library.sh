#!/bin/bash
ARCH=x64 #86
MSVC=2015 #2013

BASEPATH=$(dirname $(readlink -f $0) )

function download_git {
  url=$1
  branch=$2

  git clone ${url} --depth 1 --recursive ${branch:+--branch ${branch}}
}

function download_curl {
  url=$1
  filename=$(basename ${url})

  curl -OL ${url}
  7z x ${filename}
  rm -f ${filename}
}

function download_lib {
  url=$1
  branch=$2
  foldername=$3

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

  if  [[ ${url} == git* ]]; then
    download_git ${url} ${branch}
  else
    download_curl ${url}
  fi
  popd > /dev/null
}

function patch_lib {
  name=$1

  #Patch ICU
  patchpath=$(readlink -f "./patch/${name}.patch")
  if [[ -e  ${patchpath} ]]; then
    patch -i "${patchpath}" -p0 -fsN -d ./src/${name}
  fi

}

function build_lib {
  export VSSETUP_COMMAND='"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64'
  export CMAKE_COMMAND='"C:\Program Files (x86)\CMake\bin\cmake.exe"'

  source_dir=$1
  install_path=$2

  install_path_win=${install_path/\/c/c:}
  install_path_win=${install_path_win////\\}

  if [[ ! -d "${install_path}" ]] || [[ ${force} == true ]]; then
    cmd /c "script\\${name}.x64 ${name} ${install_path_win}"
  fi

  export ${source_dir}_PATH=${install_path}
}

url=$1
version=$2
install_root=$3
source_dir=${url##*/}
source_dir=${source_dir%.*}
branch=v${version}
output_dir=${source_dir}-${version}
force=false

OPTIND=4

while getopts ":vfs:b:o:" arg; do
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
    f)
      force=true
      ;;
    v)
      verbose=true
      ;;
    \?)
      echo "Unknown Option"
      ;;
    esac
done

if [[ ${verbose} ]]; then
  echo url=${url}
  echo version=${version}
  echo install_root=${install_root}
  echo source_dir=${source_dir}
  echo branch=${branch}
  echo output_dir=${output_dir}
  echo force=${force}
fi

download_lib ${url} ${branch} ${source_dir}
patch_lib ${source_dir}
build_lib ${source_dir} "${install_root}/${output_dir}"
