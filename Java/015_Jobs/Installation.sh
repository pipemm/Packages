#!/bin/bash

VERSION_JAVA="${VERSION_JAVA:-21}"
LOCATION_INSTALLATION='/etc/alternatives/alternative.java/'

FOLDER_ARTIFACT='053_Artifacts/'
mkdir --parent "${FOLDER_ARTIFACT%/}/"
FILE_LIST="${FOLDER_ARTIFACT%/}/linux_list_temurin${VERSION_JAVA}.json"
FILE_LATEST="${FOLDER_ARTIFACT%/}/linux_latest_temurin${VERSION_JAVA}.json"

URL_API="https://api.adoptium.net/v3/assets/latest/${VERSION_JAVA}/hotspot?os=linux&architecture=x64"
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
  curl --output "${SAVE_JAVA}" --verbose --silent --location "${LINK_JAVA}"
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

LOCATION_INSTALLATION="${LOCATION_INSTALLATION%/}/"
sudo mkdir --parent "${LOCATION_INSTALLATION%/}/"

sudo tar --extract --verbose --gunzip --file="${SAVE_JAVA}" --directory="${LOCATION_INSTALLATION%/}/"
JAVA_BIN=$(ls --directory ${LOCATION_INSTALLATION%/}/*/bin/)

if [ -n "${GITHUB_ENV}" ]
then
  PATH="${JAVA_BIN%/}:${PATH}"
  JAVA_HOME="${JAVA_BIN%bin/}"
  echo "PATH=${PATH}"           >> "${GITHUB_ENV}"
  echo "JAVA_HOME=${JAVA_HOME}" >> "${GITHUB_ENV}"
fi

echo "PATH=${PATH}"
echo "JAVA_HOME=${JAVA_HOME}"
