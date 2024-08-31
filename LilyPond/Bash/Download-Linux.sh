#!/usr/bin/bash

if [[ -z "${URL_PACKAGE}" ]]
then
  exit 1
fi

echo "${URL_PACKAGE##*/}"

FILE_PACKAGE="${URL_PACKAGE##*/}"
NAME_PACKAGE="${FILE_PACKAGE%.zip}"

FOLDER_PACK="Package/"
FOLDER_DL="${FOLDER_PACK%/}/Download/"
mkdir --parent "${FOLDER_DL%/}/"
if [[ $? ]]
then
  mkdir -p "${FOLDER_DL%/}/"
fi


FILE_PACKAGE="${FOLDER_DL%/}/${FILE_PACKAGE}"
curl --output "${FILE_PACKAGE}" --location "${URL_PACKAGE}"

TAR_FOLDER=$(
  tar --list --gunzip --file="${FILE_PACKAGE}" |
  head --lines=1
)

tar --extract --gunzip --verbose \
  --file="${FILE_PACKAGE}" \
  --directory="${FOLDER_PACK}"

FOLDER_ARTIFACT="${FOLDER_PACK%/}/${TAR_FOLDER%/}/"
if [[ -d "${FOLDER_ARTIFACT}" ]]
then
  FOLDER_ARTIFACT="${PWD%/}/${FOLDER_ARTIFACT%/}/"
else
  exit 1
fi

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "FOLDER_ARTIFACT=${FOLDER_ARTIFACT}"
  echo "FOLDER_ARTIFACT=${FOLDER_ARTIFACT}" >> "${GITHUB_ENV}"
  echo "NAME_PACKAGE=${NAME_PACKAGE}"
  echo "NAME_PACKAGE=${NAME_PACKAGE}"       >> "${GITHUB_ENV}"
fi
