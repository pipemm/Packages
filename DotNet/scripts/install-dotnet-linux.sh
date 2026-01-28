#!/usr/bin/bash

FolderHome="${HOME%/}/"
FolderPack="${FolderHome%/}/.packages/"
FolderDown="${FolderPack%/}/Downloads/DotNet/"
FolderInstall="${FolderPack%/}/dotnet/runtime/"

find "${FolderDown%/}/" -type f -name '*.tar.gz' -print |
  sort --reverse --version-sort |
  head --lines=1 |
  while read -r pack
  do
    packname="${pack##*/}"
    packname="${packname%.tar.gz}"
    FolderInstall2="${FolderInstall%/}/${packname}/"

    if [[ ! -d "${FolderInstall2%/}/" ]]
    then
      echo "installing to ${FolderInstall2%/}/ ..."
      mkdir --parent "${FolderInstall2%/}/"
      tar --extract --ungzip --verbose --file="${pack}" --directory="${FolderInstall2%/}/"
    else
      echo "install location exists : ${FolderInstall2%/}/"
    fi
  done
