#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_urls='get-urls-hive-jdbc-latest.sh'

bash "${sh_urls}" |
  sed --silent '/\/hive-jdbc-[0-9.]\+-standalone\.jar$/p'
