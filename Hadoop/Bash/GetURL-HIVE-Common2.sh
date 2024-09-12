#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

echo "${URL_FILES}"

if [[ -z "${URL_FILES}" ]]
then
  exit 1
fi

curl "${URL_FILES}"
