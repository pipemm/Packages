#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_urls='get-urls-hadoop-3.sh'
urls=$(bash "${sh_urls}")

(
  echo "${urls}" | 
    sed --silent '/hadoop-[0-9.]\+-lean\.tar\.gz$/p' |
    sort --reverse --version-sort |
    head --lines=1
  echo "${urls}" | 
    sed --silent '/hadoop-[0-9.]\+\.tar\.gz$/p' |
    sort --reverse --version-sort |
    head --lines=1
) | head --lines=1

