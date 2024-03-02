#!/bin/bash

VERSION='21'

FOLDER_ARTIFACT='053_Artifacts/'
mkdir --parent "${FOLDER_ARTIFACT%/}/"
FILE_LIST="${FOLDER_ARTIFACT%/}/linux_list_temurin${VERSION}.json"
FILE_LATEST="${FOLDER_ARTIFACT%/}/linux_latest_temurin${VERSION}.json"

URL_API="https://api.adoptium.net/v3/assets/latest/${VERSION}/hotspot?os=linux&architecture=x64"
curl "${URL_API}" > "${FILE_LIST}"

cat "${FILE_LIST}" |
  jq '[.[] | select(.binary.image_type == "jdk") ]' |
  jq 'sort_by( .binary.updated_at ) | reverse | .[0]' |
  tee "${FILE_LATEST}"

LINK_JAVA=$(
  cat "${FILE_LATEST}" |
    jq --raw-output '.binary.package.link'
  )
NAME_JAVA=$(
  cat "${FILE_LATEST}" |
    jq --raw-output '.binary.package.name'
  )
SAVE_JAVA="${FOLDER_ARTIFACT%/}/${NAME_JAVA}"

if [ ! -f "${SAVE_JAVA}" ]
then
  echo "Downloading ${LINK_JAVA} as ${NAME_JAVA}"
  curl --output "${SAVE_JAVA}" --verbose --no-progress-meter --location "${LINK_JAVA}"
fi

CODE_CHECKSUM=$(
  cat "${FILE_LATEST}" |
    jq --raw-output '.binary.package.checksum'
  )
LINK_CHECKSUM=$(
  cat "${FILE_LATEST}" |
    jq --raw-output '.binary.package.checksum_link'
  )

SAVE_CHECKSUM="${FOLDER_ARTIFACT%/}/${LINK_CHECKSUM##*/}"
curl --verbose --no-progress-meter --location "${LINK_CHECKSUM}" |
  tee "${SAVE_CHECKSUM}"
  

echo "Expecting Checksum   : "
echo "    ${CODE_CHECKSUM}"

echo "Calculating Checksum : "
echo -n "    "
cat "${SAVE_JAVA}" | sha256sum

