#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

if [[ -z "${URL_FILES}" ]]
then
  exit 1
fi

FILE_URLS="${FOLDER_DL%/}/URLs.txt"
curl "${URL_FILES}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
  sed '/^\//d' |
  while read -r file
  do
    echo "${URL_FILES%/}/${file}"
  done > "${FILE_URLS}"

cat "${FILE_URLS}" |
  sed --silent '/\/hadoop-[0-9.]\+\.tar\.gz$/p' |
  while read -r url
  do
    echo "${url##*/} ${url}"
  done |
  sort --reverse --version-sort --key=1 |
  cut --delimiter=' ' --fields=2 |
  head --lines=1
  
