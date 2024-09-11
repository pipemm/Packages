#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

FILE_URLS="${FOLDER_DL%/}/URLs.txt"
## https://hadoop.apache.org/releases.html
URL_RELEASE='https://hadoop.apache.org/releases.html'
curl "${URL_RELEASE}" |
  sed --silent 's!^.*"\(http[s]\?[^"]\+\)".*$!\1!p' > "${FILE_URLS}"

cat "${FILE_URLS}"

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

echo "URL_TARBALL=${URL_TARBALL}"