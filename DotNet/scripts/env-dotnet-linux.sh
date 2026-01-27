#!/usr/bin/bash

FolderPackage="${HOME%/}/.packages/dotnet/"
if [[ -d "${FolderPackage%/}/" ]]
then
  PACKAGE_LOCATION=$(
    find "${FolderPackage%/}/" -maxdepth 1 -mindepth 1 -type d -name 'dotnet-*-*-linux-x64' |
    head --lines=1
  )
fi

if [[ -n "${PACKAGE_LOCATION%/}/" ]]
then
  PACKAGE_LOCATION="${PACKAGE_LOCATION%/}/"
  PACKAGE_NAME="${PACKAGE_LOCATION%/}"
  PACKAGE_NAME="${PACKAGE_NAME##*/}"
  PATH="${PACKAGE_LOCATION%/}:${PATH}"
fi

