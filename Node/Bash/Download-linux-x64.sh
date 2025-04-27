#!/usr/bin/bash

if [[ -z "${NODE_VERSION}" ]]
then
  exit 1
fi

FolderReleases='Releases/'
FolderDownload='Download/'
mkdir --parent "${FolderDownload%/}/"
FolderUnzipped='Unzipped/'
mkdir --parent "${FolderUnzipped%/}/"

url_prefix='https://nodejs.org/dist/'
url_download="${url_prefix%/}/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz"
filename="${url_download##*/}"
targz_download="${FolderDownload%/}/${filename}"
curl --output "${targz_download}" "${url_download}"
tar --extract --xz --file="${targz_download}" --directory="${FolderUnzipped%/}/"

ArtifactName="${filename%.tar.gz}"

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "ArtifactName=${ArtifactName}"
  echo "ArtifactName=${ArtifactName}" >> "${GITHUB_ENV}"
fi
