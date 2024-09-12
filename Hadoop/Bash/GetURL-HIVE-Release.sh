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

URL_SHA512=$(
  cat "${FILE_URLS}" |
  grep --fixed-strings "${HADOOP_VERSION}.sha512" --ignore-case |
  head --lines=1
)

URL_ASC=$(
  cat "${FILE_URLS}" |
  grep --fixed-strings "${HADOOP_VERSION}.asc" --ignore-case |
  head --lines=1
)

if [[ -z "${GITHUB_OUTPUT}" ]]
then
  exit 0
fi

if [[ -n "${URL_SHA512}" ]]
then
  echo "URL_SHA512=${URL_SHA512}"
  echo "URL_SHA512=${URL_SHA512}" >> "${GITHUB_OUTPUT}"
fi

if [[ -n "${URL_ASC}" ]]
then
  echo "URL_ASC=${URL_ASC}"
  echo "URL_ASC=${URL_ASC}" >> "${GITHUB_OUTPUT}"
fi
