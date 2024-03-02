#!/bin/bash

FOLDER_ARTIFACT='053_Artifacts/'
mkdir --parent "${FOLDER_ARTIFACT%/}/"
FILE_LIST="${FOLDER_ARTIFACT%/}/temurin21.json"

URL_API='https://api.adoptium.net/v3/assets/latest/21/hotspot?os=linux&architecture=x64'
curl "${URL_API}" > "${FILE_LIST}"

cat "${FILE_LIST}" |
  jq '[.[] | select(.binary.image_type == "jdk")]'

## jq '[.[] | .binary.image_type]'

