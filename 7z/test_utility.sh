#!/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

folder_7z='bin7z/'
utility7z=$(ls ${folder_7z%/}/*/7z*)

if [[ -z "${utility7z}" ]]
then
  echo 'utility not found'
  echo 1
fi

"${utility7z}" --help

PATH_7Z="${utility7z%/*}"

PATH="${PWD}/${PATH_7Z}:${PATH}"

which -a 7zz
