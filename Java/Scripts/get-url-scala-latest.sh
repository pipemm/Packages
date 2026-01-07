#!/usr/bin/bash

## https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#get-the-latest-release
API_ENDPOINT='https://api.github.com/'
OWNER='scala'
REPO='scala3'
API_URL="${API_ENDPOINT%/}/repos/${OWNER}/${REPO}/releases/latest"

curl --silent --show-error --fail --location \
  -header 'Accept: application/vnd.github+json' \
  -header "Authorization: Bearer ${GITHUB_TOKEN}" \
  -header 'X-GitHub-Api-Version: 2022-11-28' \
  "${API_URL}" |
  jq --raw-output '.assets[].browser_download_url'

