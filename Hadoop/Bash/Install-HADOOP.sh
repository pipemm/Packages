#!/usr/bin/bash

FOLDER_DL='Download/'

LOC_HADOOP=$(
  ls ${FOLDER_DL%/}/hadoop-*.tar.gz |
  head --lines=1
)

TAR_HADOOP="${LOC_HADOOP##*/}"
VERSION_HADOOP="${TAR_HADOOP%.tar.gz}"

echo "${TAR_HADOOP}"
echo "${VERSION_HADOOP}"

echo 'SHA512Sum Calculation'
cat "${LOC_HADOOP}" |
  sha512sum

if [[ -n "${CHECK_SHA512}" ]]
then
  echo
  echo 'SHA512 Check'
  echo "${CHECK_SHA512}"
fi

FOLDER_INS='Installation/'
mkdir --parent "${FOLDER_INS%/}/"

tar -xzf "${LOC_HADOOP}" -C "${FOLDER_INS%/}/"

ls ${FOLDER_INS%/}/*.*
