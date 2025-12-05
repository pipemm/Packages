#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_urls='get-urls-hadoop-3.sh'

bash "${sh_urls}" 