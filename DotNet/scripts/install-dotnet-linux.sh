#!/usr/bin/bash

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
    if [[ ! -d "${FolderInstall2%/}/" ]]
    then
      mkdir --parent "${FolderInstall2%/}/"
      tar --extract --ungzip --verbose --file="${pack}" --directory="${FolderInstall2%/}/"
    fi
  done
