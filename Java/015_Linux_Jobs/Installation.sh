#!/bin/bash

VERSION='21'

FOLDER_ARTIFACT='053_Artifacts/'
mkdir --parent "${FOLDER_ARTIFACT%/}/"
FILE_LIST="${FOLDER_ARTIFACT%/}/linux_list_temurin${VERSION}.json"
FILE_LATEST="${FOLDER_ARTIFACT%/}/linux_latest_temurin${VERSION}.json"

URL_API="https://api.adoptium.net/v3/assets/latest/${VERSION}/hotspot?os=linux&architecture=x64"
curl "${URL_API}" > "${FILE_LIST}"

cat "${FILE_LIST}" |
  jq '[.[] | select(.binary.image_type == "jdk") ]' |
  jq 'sort_by( .binary.updated_at ) | reverse | .[0]' > "${FILE_LATEST}"

cat "${FILE_LATEST}"


