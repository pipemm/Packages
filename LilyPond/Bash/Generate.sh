#!/usr/bin/bash

which -a lilypond
echo $?
if [[ $? ]]
then
  exit 1
fi

FOLDER_OUT='Output/'
mkdir --parent "${FOLDER_OUT}"
FOLDER_CODE='Code/'
if [[ -d "${FOLDER_CODE}" ]]
then
  ls "${FOLDER_CODE}" |
  while read -r filec
  do
    lilypond "${filec}"
  done
fi
