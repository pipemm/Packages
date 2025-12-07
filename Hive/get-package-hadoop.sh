#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'

ls ${FolderPackage%/}/Downloads*/hadoop-*.tar.gz |
  tac |
  head --lines=1
