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

URL_TARBALL=$(
  cat "${FILE_URLS}" |
  sed --silent '/\/hadoop-[0-9.]\+\.tar\.gz$/p' |
  while read -r url
  do
    echo "${url##*/} ${url}"
  done |
  sort --reverse --version-sort --key=1 |
  cut --delimiter=' ' --fields=2 |
  head --lines=1
)

if [[ -z "${URL_TARBALL}" ]]
then
  exit 1
fi
URL_DOWNLOAD="${URL_TARBALL}"

if [[ -n "${GITHUB_OUTPUT}" ]]
then
  echo "URL_DOWNLOAD=${URL_DOWNLOAD}"
  echo "URL_DOWNLOAD=${URL_DOWNLOAD}" >> "${GITHUB_OUTPUT}"
fi

HADOOP_VERSION="${URL_TARBALL##*/}"
