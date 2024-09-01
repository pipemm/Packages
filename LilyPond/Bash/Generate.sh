#!/usr/bin/bash


which -a lilypond
if [[ $? -ne 0 ]]
then
  exit 1
fi
lilypond=$(which lilypond)

FOLDER_OUT='Output/'
mkdir --parent "${FOLDER_OUT}"
FOLDER_CODE='Code/'
if [[ -d "${FOLDER_CODE}" ]]
then
  ls ${FOLDER_CODE%/}/*.ly |
  while read -r filec
  do
    echo Compiling "${filec}"
    sudo "${lilypond}" --output="${FOLDER_OUT}" --pdf --png "${filec}"
  done
fi
