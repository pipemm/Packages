#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderPackage='Packages/'
FolderBinary="${FolderPackage%/}/Binaries/"
mkdir --parent "${FolderBinary%/}/"

################################################################################
########## HADOOP UNPACK #######################################################

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
    tar --extract --gunzip --file="${tarfile}" --directory="${FolderBinary%/}/"
  done

########## HIVE UNPACK #########################################################
################################################################################
########## JDK UNPACK ##########################################################

ls ${FolderPackage%/}/Downloads*/OpenJDK*-jdk_x64_linux_hotspot_*.tar.gz |
  tac |
  head --lines=1 |
  while read -r tarfile
  do
    tar --extract --gunzip --file="${tarfile}" --directory="${FolderBinary%/}/"
  done

########## JDK UNPACK ##########################################################
################################################################################
########## JRE UNPACK ##########################################################

ls ${FolderPackage%/}/Downloads*/OpenJDK*-jre_x64_linux_hotspot_*.tar.gz |
  tac |
  head --lines=1 |
  while read -r tarfile
  do
    tar --extract --gunzip --file="${tarfile}" --directory="${FolderBinary%/}/"
  done

########## JRE UNPACK ##########################################################
################################################################################

