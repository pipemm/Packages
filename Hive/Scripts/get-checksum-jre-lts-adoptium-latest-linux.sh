#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_urls='get-urls-java-lts-adoptium-latest.sh'
urls=$(bash "${sh_urls}")

echo "${urls}" |
  sed --silent '/jre_x64_linux_hotspot/p' |
  sed --silent '/\.sha256\.txt$/p' |
  head --lines=1 |
  while read -r surl
  do
    curl --silent --show-error --fail --retry 3 --retry-delay 2 --location "${surl}" |
      sed --silent 's/[ ]\+OpenJDK.*$//p' |
      head --lines=1
  done

