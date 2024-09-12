#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

FILE_URL0="${FOLDER_DL%/}/URL0.txt"
## https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
## - http://www.apache.org/dyn/closer.cgi/hadoop/common/
URL_COMMON_PAGE='https://www.apache.org/dyn/closer.cgi/hadoop/common/'
curl "${URL_COMMON_PAGE}" |
  sed '/Alternate download locations are suggested below\./q' |
  sed '0,/We suggest the following location for your download:/d' |
  sed --silent 's!^.*href="\(http[s]\?[^"]\+\)".*$!\1!p' > "${FILE_URL0}"

URL_COMMON=$(
  cat "${FILE_URL0}" |
  head --lines=1
)

if [[ -z "${URL_COMMON}" ]]
then
  exit 1
fi

FILE_URL1="${FOLDER_DL%/}/URL1.txt"
URL_COMMON="${URL_COMMON%/}/"
curl "${URL_COMMON}" |
  sed --silent 's!^.*href="\([^"]\+\)".*$!\1!p' |
  sed '/^\//d' |
  sed --silent '/\/$/p' |
  while read -r subfolder
  do
    echo "${URL_COMMON%/}/${subfolder%/}/"
  done > "${FILE_URL1}"

URL_LATEST=$(
  cat "${FILE_URL1}" |
  while read -r url
  do
    vname="${url%/}"
    vname="${vname##*/}"
    echo "${vname} ${url}"
  done |
  sed --silent '/^hadoop-/p' |
  sort --reverse --version-sort --key=1 |
  cut --delimiter=' ' --fields=2 |
  head --lines=1
)

URL_STABLE=$(
  cat "${FILE_URL1}" |
  while read -r url
  do
    vname="${url%/}"
    vname="${vname##*/}"
    echo "${vname} ${url}"
  done |
  sed --silent '/^stable /p' |
  cut --delimiter=' ' --fields=2 |
  head --lines=1
)

if [[ -z "${GITHUB_OUTPUT}" ]]
then
  exit 0
fi

if [[ -n "${URL_LATEST}" ]]
then
  echo "URL_LATEST=${URL_LATEST}"
  echo "URL_LATEST=${URL_LATEST}" >> "${GITHUB_OUTPUT}"
fi

if [[ -n "${URL_STABLE}" ]]
then
  echo "URL_STABLE=${URL_STABLE}"
  echo "URL_STABLE=${URL_STABLE}" >> "${GITHUB_OUTPUT}"
fi
