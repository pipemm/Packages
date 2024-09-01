#!/usr/bin/bash

sudo echo "${PATH}"
sudo which -a lilypond
if [[ $? -ne 0 ]]
then
  echo exit 1
fi

FOLDER_OUT='Output/'
mkdir --parent "${FOLDER_OUT}"
FOLDER_CODE='Code/'
if [[ -d "${FOLDER_CODE}" ]]
then
  ls ${FOLDER_CODE%/}/*.ly |
  while read -r filec
  do
    echo Compiling "${filec}"
    sudo lilypond --output="${FOLDER_OUT}" --pdf --png "${filec}"
  done
fi
