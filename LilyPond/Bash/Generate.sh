#!/usr/bin/bash

which lilypond
if [[ $? ]]
then
  exit 1
fi

FOLDER_CODE='Code/'
if [[ -d "${FOLDER_CODE}" ]]
then
  ls "${FOLDER_CODE}" |
  while read -r filec
  do
    lilypond "${filec}"
  done
fi
