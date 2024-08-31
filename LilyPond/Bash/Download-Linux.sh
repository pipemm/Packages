#!/usr/bin/bash

if [[ -z "${URL_PACKAGE}" ]]
then
  exit 1
fi

echo "${URL_PACKAGE##*/}"

FILE_PACKAGE="${URL_PACKAGE##*/}"
NAME_PACKAGE="${FILE_PACKAGE%.tar.gz}"

FOLDER_PACK="Package/"
FOLDER_DL="${FOLDER_PACK%/}/Download/"
mkdir --parent "${FOLDER_DL%/}/"

FILE_PACKAGE="${FOLDER_DL%/}/${FILE_PACKAGE}"
curl --output "${FILE_PACKAGE}" --location "${URL_PACKAGE}"

tar --extract --gunzip --verbose \
  --file="${FILE_PACKAGE}" \
  --directory="${FOLDER_PACK}"

ls Package/
echo "${NAME_PACKAGE}"
