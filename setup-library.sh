#!/bin/bash
BASEPATH=$(dirname $(readlink -f $0) )

function download_git {
  url=$1
  branch=$2

  if [[ $branch == @* ]]; then
    git clone ${url} --recursive --depth 100
    pushd > /dev/null
    git checkout ${branch:1}
    popd > /dev/null
  else
    git clone ${url} --depth 1 --recursive ${branch:+--branch ${branch}}
  fi
}

function download_curl {
  url=$1
  filename=$(basename ${url})

  curl -OL ${url}

  if [[ ${filename} == *.tar.gz ]]; then
    7z x ${filename}
    7z x ${filename%.*}
    rm -f ${filename%.*}
  else
    7z x ${filename}
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

  if [[ ${force_git} ]] || [[ ${url} == git* ]]; then
    download_git ${url} ${branch}
  else
    download_curl ${url}
  fi
  popd > /dev/null

  patch_lib ${source_dir}
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

  if [[ $BUILD_ARCH == "x64" ]]; then
    VS_ARCH_ARG=amd64
  else
    VS_ARCH_ARG=x86
  fi

  if [[ $MSVC_VER == 2013 ]]; then
    VS_VER_NUM=12.0
  elif [[ $MSVC_VER == 2015 ]]; then
    VS_VER_NUM=14.0
  else
    echo "Invalid MSVC_VER=$MSVC_VER"
    return
  fi

  export VSSETUP_COMMAND="\"C:\\Program Files (x86)\\Microsoft Visual Studio $VS_VER_NUM\\VC\\vcvarsall.bat\" $VS_ARCH_ARG"
  export CMAKE_COMMAND='"C:\Program Files (x86)\CMake\bin\cmake.exe"'

  source_dir=$1
  install_path=$2
  base_name=$3

  install_path_win=$(cygpath -m $install_path)
  if [[ ! -d "${install_path}" ]] || [[ ${force} == true ]]; then
    cmd //C "script\\${base_name}.x64 ${source_dir} ${install_path_win}"
  fi
}

url=$1
version=$2
install_root=${EXT_LIB_INSTALL_ROOT}
source_dir=${url##*/}
source_dir=${source_dir%.*}
branch=v${version}
base_name=${source_dir}
output_dir=${source_dir}-${version}

force=false

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

download_lib ${url} ${branch} ${source_dir} ${force_git}

build_lib ${source_dir} "${install_root}/${output_dir}" ${base_name}
