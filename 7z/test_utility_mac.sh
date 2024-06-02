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

utility7zz="${utility7z##*/}"

PATH_7Z="${PWD}/${utility7z%/*}"
PATH="${PATH_7Z}:${PATH}"

which -a "${utility7zz}"
"${utility7zz}" --help


