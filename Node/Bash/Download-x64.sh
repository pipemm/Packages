#!/usr/bin/bash

if [[ -z "${VERSION}" ]]
then
  exit 1
fi

FolderReleases='Releases/'
FolderDownload='Download/'
mkdir --parent "${FolderDownload%/}/"

url_prefix='https://nodejs.org/dist/'

cat "${FolderReleases%/}/release-files.txt" |
  sed --silent '/-win-x64\.zip$/p' |
  head --lines=1 |
  while read -r filename
  do
    ver_node="${filename}"
    ver_node="${ver_node%-win-x64.zip}"
    ver_node="${ver_node#node-}"
    url_download="${url_prefix%/}/${ver_node}/${filename}"
    zip_download="${FolderDownload%/}/${filename}"
    curl --output "${zip_download}" "${url_download}"
  done

