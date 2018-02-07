#!/bin/bash

cd ssh-agent
./run.sh -q
cd ..

if [[ -z "$1" ]]; then
  echo "Usage: ./run-docker.sh [android32|android64|x86_64|arm64] <output_dir> <host library dir>"
  exit
fi

platform=$1
out_dir=$2
host_libs=$3

if [[ -z "${out_dir}" ]]; then
	out_dir=$(realpath $(dirname $0)/../../Libraries-${platform})
fi

if [[ -z "${host_libs}" ]]; then
	host_libs=$(realpath ${out_dir}/../Libraries-x64)
fi

docker volume create $platform-build
set -x

MSYS_NO_PATHCONV=1 docker run --rm -it --volumes-from=ssh-agent \
-v $(realpath $(dirname $0)/..):/opt/local/external-libraries:ro \
-v $platform-build:/opt/local/$platform-build \
-v $out_dir:/opt/local/$(basename ${out_dir}) \
-v $host_libs:/opt/local/Libraries-x64 \
-e SSH_AUTH_SOCK=/.ssh-agent/socket \
-e BUILD_DIR=/opt/local/build-ext \
--name ${platform} xenial:$platform /bin/bash 
