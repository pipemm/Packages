#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_urls='get-urls-java-lts-adoptium-latest.sh'
urls=$(bash "${sh_urls}")

echo "${urls}" |
  sed --silent '/jre_x64_linux_hotspot/p' |
  sed --silent '/\.tar\.gz$/p' |
  head --lines=1
