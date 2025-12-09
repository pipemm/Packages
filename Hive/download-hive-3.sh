#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_url_hadoop='Scripts/get-url-hadoop-3.sh'
sh_hash_hadoop='Scripts/get-checksum-hadoop-3.sh'

sh_url_hive='Scripts/get-url-hive-3.sh'
sh_hash_hive='Scripts/get-checksum-hive-3.sh'

################################################################################

FolderPackage='Packages/'
FolderDownload="${FolderPackage%/}/Downloads0/"
mkdir --parent "${FolderDownload%/}/"

save_path() {
  local url="${1}"
  echo "${FolderDownload%/}/${url##*/}"
}

################################################################################
########## Java Download #######################################################

########## Java Download #######################################################
################################################################################
########## HADOOP Download #####################################################

hash_target=$(bash "${sh_hash_hadoop}")
url_download=$(bash "${sh_url_hadoop}")
file_path=$(save_path "${url_download}")
echo "Downloading ${file_path##*/}"

curl --output "${file_path}" "${url_download}"

echo    "Target SHA512: ${hash_target}"
echo -n 'Actual SHA512: '
sha512sum "${file_path}" |
  cut --delimiter=' ' --fields=1

########## FOR GITHIB ##########
if [[ -f "${GITHUB_ENV}" ]]
then
  package_name="${file_path##*/}"
  package_name="${package_name%.tar.gz}"
  NAME_HADOOP="${package_name}"
  echo "NAME_HADOOP=${NAME_HADOOP}" |
    tee --append "${GITHUB_ENV}"
fi

########## HADOOP Download #####################################################
################################################################################
########## HIVE Download #######################################################

hash_target=$(bash "${sh_hash_hive}")
url_download=$(bash "${sh_url_hive}")
file_path=$(save_path "${url_download}")
echo "Downloading ${file_path##*/}"

curl --output "${file_path}" "${url_download}"

echo    "Target SHA256: ${hash_target}"
echo -n 'Actual SHA256: '
sha256sum "${file_path}" |
  cut --delimiter=' ' --fields=1

########## FOR GITHIB ##########
if [[ -f "${GITHUB_ENV}" ]]
then
  package_name="${file_path##*/}"
  package_name="${package_name%.tar.gz}"
  NAME_HIVE="${package_name}"
  echo "NAME_HIVE=${NAME_HIVE}" |
    tee --append "${GITHUB_ENV}"
fi

########## HIVE Download #######################################################
################################################################################