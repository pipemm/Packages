#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'
FolderDownload="${FolderPackage%/}/Downloads/"
mkdir --parent "${FolderDownload%/}/"

save_path() {
  local url="${1}"
  echo "${FolderDownload%/}/${url##*/}"
}

sh_url='Scripts/get-maven-urls.sh'

urls=$(bash "${sh_url}")

sha512_target=$(
  echo "${urls}" |
  sed --silent '/tar\.gz\.sha512$/p' |
  head --lines=1 |
  while read -r url
  do
    curl --silent "${url}"
  done
)

url_download=$(
  echo "${urls}" |
  sed --silent '/tar\.gz$/p' |
  head --lines=1
)
file_path=$(save_path "${url_download}")
curl --output "${file_path}" "${url_download}"
echo "Target SHA512: ${sha512_target}"
sha512sum "${file_path}" 
