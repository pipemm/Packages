#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

sh_down='scripts/download-dotnet-linux.sh'
sh_install='scripts/install-dotnet-linux.sh'

bash "${sh_down}" 'sdk-lts'
bash "${sh_install}"

