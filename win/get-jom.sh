#!/bin/bash

if [[ ! -e jom ]]; then
  cd $1
  curl -OL http://download.qt.io/official_releases/jom/jom.zip
  7z x jom.zip
  rm jom.zip
fi
