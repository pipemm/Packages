#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

variety='sdk'
##      'sdk'
##      'sdk-lts'
##      'runtime'
##      'runtime-lts'
sh_url="get-url-dotnet-${variety}-latest-linux.sh"
sh_checksum="get-checksum-dotnet-${variety}-latest-linux.sh"
checksum_type='sha512'

FolderHome="${HOME%/}/"
FolderPack="${FolderHome%/}/.packages/"
FolderDown="${FolderPack%/}/Downloads/DotNet/"
mkdir --parent "${FolderDown%/}/"

url_download=$(bash "${sh_url}")
checksum_target=$(bash "${sh_checksum}")
checksum_cli="${checksum_type,,}sum"
checksum_name="${checksum_type^^}"

filename_download="${url_download##*/}"
file_download="${FolderDown%/}/${filename_download}"
if [[ ! -f "${file_download}" ]]
then
  echo "downloading ${filename_download} from ${url_download} ..."
  curl --silent --show-error --fail \
    --output "${file_download}" "${url_download}"
else
  echo "downloaded ${file_download}"
fi

checksum_actual=$(
  "${checksum_cli}" "${file_download}" | 
  cut --delimiter=' ' --fields=1 | 
  head --lines=1
)
echo "Target ${checksum_name} : ${checksum_target}"
echo "Actual ${checksum_name} : ${checksum_actual}"

if [[ "${checksum_target}" != "${checksum_actual}" ]]
then
  exit 1
fi
