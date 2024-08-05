#!/usr/bin/bash

RUN_ID="${ARTIFACT_RUN_ID}"
URL_API="https://api.github.com/repos/${REPOSITORY_FROM}/actions/runs/${RUN_ID}/artifacts"
  ## https://docs.github.com/en/rest/actions/artifacts?apiVersion=2022-11-28#list-workflow-run-artifacts
curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${URL_API}" |
  jq '.artifacts' |
  jq '[ .[] | select(.name | startswith("font-")) ]' |
  jq '[ .[] | {name,archive_download_url} ]' |
  jq --compact-output '.[]' |
  while read -r record
  do
    download_url=$( echo "${record}" | jq --raw-output '.archive_download_url' )
    base_name=$( echo "${record}" | jq --raw-output '.name' )
    file_type="${download_url##*/}"
    file_name="${base_name}.${file_type}"
    echo "${file_name}"
    curl --location \
      --header "Accept: application/vnd.github+json" \
      --header  "Authorization: Bearer ${GH_TOKEN}" \
      --header "X-GitHub-Api-Version: 2022-11-28" \
      --output "${file_name}" \
      "${download_url}"
  done

ls -la

