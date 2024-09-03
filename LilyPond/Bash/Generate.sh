#!/usr/bin/bash

which -a lilypond
if [[ $? -ne 0 ]]
then
  exit 1
fi

FOLDER_OUT='Output/'
mkdir --parent "${FOLDER_OUT}" 2> /dev/null
if [[ $? -ne 0 ]]
then
  mkdir -p "${FOLDER_OUT%/}/"
fi
FOLDER_CODE='Code/'
if [[ -d "${FOLDER_CODE}" ]]
then
  ls ${FOLDER_CODE%/}/*.ly |
  while read -r filec
  do
    echo Compiling "${filec}"
    lilypond --output="${FOLDER_OUT}" --pdf --png "${filec}"
  done
fi
