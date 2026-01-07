#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

API_ENDPOINT='https://api.github.com/'
OWNER='scala'
REPO='scala3'

sh_tls_version='get-version-scala-lts-latest.sh'
TAG=$(bash "${sh_tls_version}" | head --lines=1)

## https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-a-release-by-tag-name
API_URL="${API_ENDPOINT%/}/repos/${OWNER}/${REPO}/releases/tags/${TAG}"
curl --silent --show-error --fail --location \
  --header 'Accept: application/vnd.github+json' \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${API_URL}" |
  jq --raw-output '.assets[].browser_download_url'

