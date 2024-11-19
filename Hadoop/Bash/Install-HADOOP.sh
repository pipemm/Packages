#!/usr/bin/bash

FOLDER_DL='Download/'

FOLDER_INS='Installation/'
mkdir --parent "${FOLDER_INS%/}/"

LOC_HADOOP=$(
  ls ${FOLDER_DL%/}/hadoop-*.tar.gz |
  head --lines=1
)

TAR_HADOOP="${LOC_HADOOP##*/}"
VERSION_HADOOP="${TAR_HADOOP%.tar.gz}"

echo "${TAR_HADOOP}"
echo "${VERSION_HADOOP}"


