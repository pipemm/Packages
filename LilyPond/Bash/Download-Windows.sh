#!/usr/bin/bash

if [[ -z "${URL_PACKAGE}" ]]
then
  exit 1
fi

FILE_PACKAGE="${URL_PACKAGE##*/}"
NAME_PACKAGE="${FILE_PACKAGE%.zip}"

FOLDER_PACK="Package/"
FOLDER_DL="${FOLDER_PACK%/}/Download/"
mkdir --parent "${FOLDER_DL%/}/"

FILE_PACKAGE="${FOLDER_DL%/}/${FILE_PACKAGE}"
curl --output "${FILE_PACKAGE}" --location "${URL_PACKAGE}"

ZIP_FOLDER=$(
  unzip -l "${FILE_PACKAGE}" |
  head --lines=4 |
  cut --characters=31- |
  tail --lines=1
)

unzip "${FILE_PACKAGE}" -d "${FOLDER_PACK}"

FOLDER_ARTIFACT="${FOLDER_PACK%/}/${ZIP_FOLDER%/}/"
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
