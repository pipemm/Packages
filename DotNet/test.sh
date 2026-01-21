#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_url='scripts/get-url-dotnet-sdk-lts-latest-linux.sh'
sh_checksum='scripts/get-url-dotnet-sdk-lts-latest-linux.sh'

FolderHome="${HOME%/}/"
FolderPack="${FolderHome%/}/.packages/"
FolderDown="${FolderPack%/}/Downloads/DotNet/"
mkdir --parent "${FolderDown%/}/"

sh_url='scripts/get-url-dotnet-sdk-lts-latest-linux.sh'
sh_checksum='scripts/get-checksum-dotnet-sdk-lts-latest-linux.sh'
checksum_type='sha512'

url_download=$(bash "${sh_url}")
checksum_target=$(bash "${sh_checksum}")
checksum_cli="${checksum_type,,}sum"
checksum_name="${checksum_type^^}"

filename_download="${url_download##*/}"
file_download="${FolderDown%/}/${filename_download}"
echo "${file_download}"
if [[ ! -f "${file_download}" ]]
then
  echo "downloading ${filename_download} ..."
  curl --silent --show-error --fail \
    --output "${file_download}" "${url_download}"
fi

checksum_actual=$(
  "${checksum_cli}" "${file_download}" | 
  cut --delimiter=' ' --fields=1 | 
  head --lines=1
)
echo "Target ${checksum_name} : ${checksum_target}"
echo "Actual ${checksum_name} : ${checksum_actual}"

