#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
getContext="${thispath%/}/../JavaScript/get-context.js"

if [[ -z "${UserAgent}" ]]
then
  UserAgent=$(
    curl --head --verbose 'https://curl.se/' 2>&1 | 
    sed --silent 's/^> user-agent:[ ]*//p' |
    head --lines=1
  )
fi
FolderDownload='Releases/'
mkdir --parent "${FolderDownload%/}/"

LatestJSON=$(
  curl 'https://nodejs.org/en/download' \
  --header "user-agent: ${UserAgent}" |
  sed 's|\(<script>\)|\n\1|g' |
  sed 's|\(</script>\)|\1\n|g' |
  sed --silent 's|^<script>\(.*\)</script>$|\1|p' |
  sed --silent 's|^self\.__next_f\.push(\(.*\))$|\1|p' |
  sed --silent '/releases/p' |
  while read -r line
  do
    echo "var data=${line};" |
      node "${getContext}" 'data' |
      jq --raw-output '.[1]?'
  done |
  sed --silent 's!^[0-9]*:[A-Z]*!!p' |
  sed --silent '/releases/p' |
  head --lines=1 |
  while read -r line
  do
    echo "var data=${line};" |
      node "${getContext}" 'data'
  done |
  jq '.[3]?.releases' |
  tee "${FolderDownload%/}/releases.json" |
  jq '[.[] | select(.isLts)]' |
  jq 'sort_by(.major, .endOfLife) | reverse' |
  jq --compact-output '.[0]? | {major, version, versionWithPrefix, releaseDate}'
)
Version=$(echo "${LatestJSON}" | jq --raw-output '.versionWithPrefix?')
echo "${LatestJSON}" | jq --raw-output '.versionWithPrefix?'

curl "https://nodejs.org/en/blog/release/${Version}" \
  --header 'rsc: 1' \
  --header "user-agent: ${UserAgent}" |
  sed '0,/Hash: SHA256/d' |
  sed '/^--/,$d' |
  sed '/^$/d' |
  tee "${FolderDownload%/}/release-sha256.txt" "${FolderDownload%/}/release-${Version}-sha256.txt" |
  sed 's/^[0-9a-z]\{64\}[ ]\+//' |
  tee "${FolderDownload%/}/release-${Version}-files.txt"
