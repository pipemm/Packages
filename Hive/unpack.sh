#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'
FolderBinary="${FolderPackage%/}/Binaries/"
mkdir --parent "${FolderBinary%/}/"

################################################################################
########## HADOOP UNPACK #######################################################

tarfile=$(bash get-package-hadoop.sh)

ls ${FolderPackage%/}/Downloads*/hadoop-*.tar.gz |
  tac |
  head --lines=1 |
  while read -r tarfile
  do
    tar --extract --gunzip --file="${tarfile}" --directory="${FolderBinary%/}/"
  done

########## HADOOP UNPACK #######################################################
################################################################################
########## HIVE UNPACK #########################################################

ls ${FolderPackage%/}/Downloads*/apache-hive-*.tar.gz |
  tac |
  head --lines=1 |
  while read -r tarfile
  do
    tar -xzf "${tarfile}" -C "${FolderBinary%/}/"
  done

########## HIVE UNPACK #########################################################
################################################################################
