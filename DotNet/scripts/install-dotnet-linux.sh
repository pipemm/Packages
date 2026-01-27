#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath%/}/"

InstallName='dotnet'
FolderHome="${HOME%/}/"
FolderPack="${FolderHome%/}/.packages/"
FolderDown="${FolderPack%/}/Downloads/DotNet/"
FolderInstall="${FolderPack%/}/${InstallName}/"

find "${FolderDown%/}/" -type f -name '*.tar.gz' -print
