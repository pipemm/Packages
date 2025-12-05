#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_url='Scripts/get-url-hadoop-3.sh'
sh_hash='Scripts/get-checksum-hadoop-3.sh'

################################################################################

FolderPackage='Packages/'
FolderDownload="${FolderPackage%/}/Downloads0/"
mkdir --parent "${FolderDownload%/}/"

save_path() {
  local url="${1}"
  echo "${FolderDownload%/}/${url##*/}"
}

################################################################################
########## Hive Download #######################################################

hash_target=$(bash "${sh_hash}")
url_download=$(bash "${sh_url}")
file_path=$(save_path "${url_download}")
echo "Downloading ${file_path##*/}"

curl --output "${file_path}" "${url_download}"

echo    "Target SHA512: ${hash_target}"
echo -n 'Actual SHA512: '
sha512sum "${file_path}" |
  cut --delimiter=' ' --fields=1

########## Hive Download #######################################################
################################################################################
