#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

ProjectName='Demo'

sh_env='../scripts/env-dotnet-linux.sh'
bash "${sh_env}"

if [[ ! -f "${ProjectName}.csproj" ]]
then
  dotnet new console --name "${ProjectName}" --output '.'
fi
