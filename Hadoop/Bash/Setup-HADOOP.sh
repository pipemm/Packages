#!/usr/bin/bash

FOLDER_DL='Download/'

LOC_HADOOP=$(
  ls ${FOLDER_DL%/}/hadoop-*.tar.gz |
  head --lines=1
)

TAR_HADOOP="${LOC_HADOOP##*/}"
VERSION_HADOOP="${TAR_HADOOP%.tar.gz}"

echo 'SHA512Sum Calculation'
cat "${LOC_HADOOP}" |
  sha512sum

if [[ -n "${URL_SHA512}" ]]
then
  echo
  echo 'SHA512 Check'
  curl "${URL_SHA512}"
fi

FOLDER_INS='Installation/'
FOLDER_HADOOP="${FOLDER_INS%/}/${VERSION_HADOOP}/"
mkdir --parent "${FOLDER_HADOOP%/}/"

tar --extract --gunzip --file="${LOC_HADOOP}" --directory="${FOLDER_HADOOP%/}/"


if [[ -z "${GITHUB_ENV}" ]]
then
  exit 0
fi

if [[ -n "${VERSION_HADOOP}" ]]
then
  echo "VERSION_HADOOP=${VERSION_HADOOP}"
  echo "VERSION_HADOOP=${VERSION_HADOOP}" >> "${GITHUB_ENV}"
fi
