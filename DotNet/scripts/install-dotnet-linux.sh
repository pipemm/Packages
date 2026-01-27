#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

InstallName='dotnet'
FolderHome="${HOME%/}/"
FolderPack="${FolderHome%/}/.packages/"
FolderDown="${FolderPack%/}/Downloads/DotNet/"
FolderInstall="${FolderPack%/}/${InstallName}/"

find "${FolderDown%/}/" -type f -name '*.tar.gz' -print |
  sort --reverse --version-sort |
  head --lines=1 |
  while read -r pack
  do
    packname="${pack##*/}"
    packname="${packname%.tar.gz}"
    FolderInstall2="${FolderInstall%/}/${packname}/"
    echo "${FolderInstall2}"
    if [[ ! -f "${FolderInstall2%/}/" ]]
    then
      tar --list --ungzip --file="${pack}" |
        head --lines=5
    fi
  done
