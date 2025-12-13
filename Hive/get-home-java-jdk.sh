#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'
FolderBinary="${FolderPackage%/}/Binaries/"

ls --directory -1 ${PWD%/}/${FolderBinary%/}/jdk-*/ |
  sed '/-jre\/$/d' |
  tac |
  head --lines=1

