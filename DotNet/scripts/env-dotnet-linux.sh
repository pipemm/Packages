#!/usr/bin/bash

FolderPackage="${HOME%/}/.packages/dotnet/runtime/"
if [[ -d "${FolderPackage%/}/" ]]
then
  PACKAGE_LOCATION=$(
    find "${FolderPackage%/}/" -maxdepth 1 -mindepth 1 -type d -name 'dotnet-*-*-linux-x64' |
    head --lines=1
  )
fi

if [[ -n "${PACKAGE_LOCATION}" ]]
then
  PACKAGE_LOCATION="${PACKAGE_LOCATION%/}/"
  PACKAGE_NAME="${PACKAGE_LOCATION%/}"
  PACKAGE_NAME="${PACKAGE_NAME##*/}"
  export PATH="${PACKAGE_LOCATION%/}:${PATH}"
  if [[ -n "${DOTNET_ROOT}" ]]
  then
    export DOTNET_ROOT="${PACKAGE_LOCATION%/}/"
  fi
fi

