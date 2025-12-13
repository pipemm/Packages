#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_url_jdk='Scripts/get-url-jdk-lts-adoptium-latest-linux.sh'
sh_hash_jdk='Scripts/get-checksum-jdk-lts-adoptium-latest-linux.sh'

sh_url_jre='Scripts/get-url-jre-lts-adoptium-latest-linux.sh'
sh_hash_jre='Scripts/get-checksum-jre-lts-adoptium-latest-linux.sh'

################################################################################

FolderPackage='Packages/'
FolderDownload="${FolderPackage%/}/Downloads0/"
mkdir --parent "${FolderDownload%/}/"

save_path() {
  local url="${1}"
  echo "${FolderDownload%/}/${url##*/}"
}

################################################################################
########## JDK Download ########################################################

hash_target=$(bash "${sh_hash_jdk}")
url_download=$(bash "${sh_url_jdk}")
file_path=$(save_path "${url_download}")
echo "Downloading ${file_path##*/}"

curl --output "${file_path}" --location "${url_download}"

echo    "Target SHA256: ${hash_target}"
echo -n 'Actual SHA256: '
sha256sum "${file_path}" |
  cut --delimiter=' ' --fields=1

########## FOR GITHIB ##########
if [[ -f "${GITHUB_ENV}" ]]
then
  package_name="${file_path##*/}"
  package_name="${package_name%.tar.gz}"
  NAME_JDK="${package_name}"
  echo "NAME_HADOOP=${NAME_JDK}" |
    tee --append "${GITHUB_ENV}"
fi

########## JDK Download ########################################################
################################################################################
########## JRE Download ########################################################

hash_target=$(bash "${sh_hash_jre}")
url_download=$(bash "${sh_url_jre}")
file_path=$(save_path "${url_download}")
echo "Downloading ${file_path##*/}"

curl --output "${file_path}" --location "${url_download}"

echo    "Target SHA256: ${hash_target}"
echo -n 'Actual SHA256: '
sha256sum "${file_path}" |
  cut --delimiter=' ' --fields=1

########## FOR GITHIB ##########
if [[ -f "${GITHUB_ENV}" ]]
then
  package_name="${file_path##*/}"
  package_name="${package_name%.tar.gz}"
  NAME_JRE="${package_name}"
  echo "NAME_JRE=${NAME_JRE}" |
    tee --append "${GITHUB_ENV}"
fi

########## JRE Download ########################################################
################################################################################

