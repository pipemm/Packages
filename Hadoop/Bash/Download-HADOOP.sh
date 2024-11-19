#!/usr/bin/bash

if [[ -z "${URL_DOWNLOAD}" ]]
then
  echo 'URL_DOWNLOAD not found'
  exit 1
fi

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

curl --output "${FOLDER_DL%/}/${URL_DOWNLOAD##*/}" "${URL_DOWNLOAD}"

FOLDER_INS='Installation/'
mkdir --parent "${FOLDER_INS%/}/"
