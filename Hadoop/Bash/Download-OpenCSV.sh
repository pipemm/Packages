#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

webopencsvlatest='https://sourceforge.net/projects/opencsv/files/latest/download'
echo "looking at ${webopencsvlatest}"
downloadlink1=$(
  curl "${webopencsvlatest}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p'
)
echo "looking at ${downloadlink1}"
downloadlink2=$(
  curl "${downloadlink1}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p'
)
echo "looking at ${downloadlink2}"
filename="${downloadlink2%\?*}"
filename="${filename##*/}"
filesave="${FOLDER_DL%/}/${filename}"
curl --output "${filesave}" "${downloadlink2}"
