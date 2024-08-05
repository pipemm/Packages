#!/usr/bin/bash

RUN_ID="${ARTIFACT_RUN_ID}"
URL_API="https://api.github.com/repos/${REPOSITORY_FROM}/actions/runs/${RUN_ID}/artifacts"
curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${URL_API}" |
  jq '.artifacts' |
  jq '[ .[] | select(.name | startswith("font-")) ]' |
  jq '[ .[] | {name,archive_download_url} ]'
