#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'
FolderBinary="${FolderPackage%/}/Binaries/"
mkdir --parent "${FolderBinary%/}/"

ls ${FolderPackage%/}/Downloads*/hadoop-*.tar.gz |
  tac |
  while read -r tarfile
  do
    tar -xzf "${tarfile}" -C "${FolderBinary%/}/"
  done

