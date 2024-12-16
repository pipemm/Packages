#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

## https://sourceforge.net/projects/opencsv/files/opencsv/

url_download='https://sourceforge.net/projects/opencsv/files/latest/download'

curl "${url_download}" |
  sed --silent 's!^.* href="\([^"]*\)".*$!\1!p' |
  while read -r url
  do
    filename="${url%%\?*}"
    filename="${filename##*/}"
    if [[ ! -f "${filename}" ]]
    then
      curl --output "${filename}" --location "${url}"
    fi
  done
