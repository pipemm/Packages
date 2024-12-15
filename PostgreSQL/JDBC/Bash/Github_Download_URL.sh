#!/usr/bin/bash

REPOSITORY_PGJDBC='pgjdbc/pgjdbc'
## https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-the-latest-release
API_RELEASE_LATEST="https://api.github.com/repos/${REPOSITORY_PGJDBC}/releases/latest"

URL_DOWNLOAD=$(
  curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${API_RELEASE_LATEST}" |
  jq '.assets' |
  jq '[.[]|select(.name|endswith(".jar"))]' |
  jq '[.[]|select(.name|startswith("postgresql-"))]' |
  jq --raw-output '.[0] | .browser_download_url'
)

JAR_NAME="${URL_DOWNLOAD##*/}"
JDBC_VER="${JAR_NAME%.jar}"
JDBC_VER="${JDBC_VER##*-}"
echo "${JDBC_VER}"

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "URL_DOWNLOAD=${URL_DOWNLOAD}"
  echo "URL_DOWNLOAD=${URL_DOWNLOAD}" >> "${GITHUB_ENV}"
fi

## https://github.com/pgjdbc/pgjdbc/releases/latest
## https://jdbc.postgresql.org/download/
