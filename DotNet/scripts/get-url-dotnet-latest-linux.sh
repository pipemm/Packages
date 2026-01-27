#!/usr/bin/bash

variety="${1}"
if [[ "${variety,,}" == 'runtime' ]]
then
  variety='runtime'
else
  variety='sdk'
fi

sed_pattern_pack1='/\/\(sdk\|runtime\)-[0-9.]\+-linux-x64-binaries$/'
sed_pattern_pack2="/\/\(${variety}\)-[0-9.]\+-linux-x64-binaries$/"

url_domain='https://dotnet.microsoft.com/'
url_page="${url_domain%/}/download/dotnet"

curl --silent --show-error --fail "${url_page}" |
  sed --silent 's!^.* href="[^"]*/download/dotnet/\([0-9.]*\)".*$\|^.* class="badge badge-\(lts\|sts\)".*$!\1\2!p' |
  sed --silent '/^[0-9.]\+/p' |
  sort --reverse --version-sort | 
  head --lines=1 | 
  while read -r version
  do
    url_version="${url_page%/}/${version}"
    curl --silent --show-error --fail "${url_version}"
  done |
  sed --silent 's!^.* href="\([^"]\+\/\(sdk\|runtime\)-[^"]*\)".*$!\1!p' |
  sed --silent "${sed_pattern_pack1}p" |
  sed --silent "${sed_pattern_pack2}p" |
  sort --reverse --version-sort |
  head --lines=1 |
  while read -r urlpart
  do
    url_down_and_checksum="${url_domain%/}/${urlpart#/}"
    curl --silent --show-error --fail "${url_down_and_checksum}"
  done |
 sed --silent 's!^.* href="\(https://builds.dotnet.microsoft.com/dotnet/[^"]\+\)".*$!\1!p' |
 head --lines=1

  
