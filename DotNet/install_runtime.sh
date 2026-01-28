#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

sh_down='scripts/download-dotnet-linux.sh'
sh_install='scripts/install-dotnet-linux.sh'
sh_env='scripts/env-dotnet-linux.sh'
sh_test='scripts/test-env-linux.sh'

bash "${sh_down}" 'sdk-lts'
bash "${sh_install}"

source "${sh_env}"
bash "${sh_test}"
