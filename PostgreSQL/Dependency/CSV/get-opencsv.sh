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
      echo "downloading ${url}"
      curl --output "${filename}" --location "${url}"
    fi

    JAR_NAME_OPENCSV="${filename%.jar}"
    if [[ -n "${GITHUB_ENV}" ]]
    then
      echo "JAR_NAME_OPENCSV=${JAR_NAME_OPENCSV}"
      echo "JAR_NAME_OPENCSV=${JAR_NAME_OPENCSV}" >> "${GITHUB_ENV}"
    fi
  done
