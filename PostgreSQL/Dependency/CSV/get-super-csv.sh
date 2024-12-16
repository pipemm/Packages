#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

## https://github.com/super-csv/super-csv/releases/latest
REPO_OWNER='super-csv'
REPO_NAME='super-csv'

## https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-the-latest-release
API_LATEST="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest"
curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${API_LATEST}" |
  jq '.assets' |
  jq '[.[] | select(.name | startswith("super-csv-distribution-")) ]' |
  jq '[.[] | select(.name | endswith("-bin.zip")) ]' |
  jq '[.[] | .browser_download_url]' |
  jq  --raw-output '@tsv' |
  while read -r url
  do
    filename="${url##*/}"
    if [[ ! -f "${filename}" ]]
    then
      echo "downloading ${url}"
      curl --output "${filename}" --location "${url}"
    fi
    unzip -l "${filename}" |
      sed --silent 's!^.* \(super-csv/super-csv-[0-9.]\+\.jar\)$!\1!p' |
      while read -r inpath
      do
        jarfile="${inpath##*/}"
        if [[ ! -f "${jarfile}" ]]
        then
          unzip -j "${filename}" "${inpath}"
        fi
        
        JAR_NAME_SUPERCSV="${jarfile%.jar}"
        if [[ -n "${GITHUB_ENV}" ]]
        then
          echo "JAR_NAME_SUPERCSV=${JAR_NAME_SUPERCSV}"
          echo "JAR_NAME_SUPERCSV=${JAR_NAME_SUPERCSV}" >> "${GITHUB_ENV}"
        fi
      done
  done

