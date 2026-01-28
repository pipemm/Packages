#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

ProjectName='Demo'

sh_env='../scripts/env-dotnet-linux.sh'
bash "${sh_env}"

dotnet new console --name 'Demo' --output '.'
