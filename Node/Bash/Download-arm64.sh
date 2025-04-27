#!/usr/bin/bash

if [[ -z "${NODE_VERSION}" ]]
then
  exit 1
fi

FolderReleases='Releases/'
FolderDownload='Download/'
mkdir --parent "${FolderDownload%/}/"
FolderUnzipped='Unzipped/'

url_prefix='https://nodejs.org/dist/'
url_download="${url_prefix%/}/${NODE_VERSION}/node-${NODE_VERSION}-darwin-arm64.tar.gz"
filename="${url_download##*/}"
targz_download="${FolderDownload%/}/${filename}"
curl --output "${targz_download}" "${url_download}"
unzip "${targz_download}" -d "${FolderUnzipped%/}/"

