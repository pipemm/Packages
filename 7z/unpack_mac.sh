#!/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

folder_dl='package7z/'

file_package=$(ls "${folder_dl%/}"/*.tar.xz | head --lines=1)

if [[ -z "${file_package}" ]]
then
  echo 'package not found'
  echo 1
fi

subfolder="${file_package##*/}"
subfolder="${subfolder%.tar.xz}"

folder_7z='bin7z/'
mkdir -p "${folder_7z%/}/${subfolder}/"

tar --extract --xz --file="${file_package}" --directory="${folder_7z%/}/${subfolder}/"


