#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

if [[ -z "${URL_FILES}" ]]
then
  exit 1
fi

curl "${URL_FILES}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
  sed '/^\//d' |
  while read -r file
  do
    echo "${URL_FILES%/}/${file}"
  done

