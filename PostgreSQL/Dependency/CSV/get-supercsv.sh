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
  --header "Accept: application/vnd.github+json" \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header "X-GitHub-Api-Version: 2022-11-28" \
  "${API_LATEST}"
