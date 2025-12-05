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
    tar -xzf "${tarfile}" -C "${FolderBinary%/}/"
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

HIVE_HOME_VAR=$(bash get-home-hive.sh)
CONFIG_HIVE_TEMPLATE="${HIVE_HOME_VAR%/}/conf/hive-default.xml.template"
CONFIG_HIVE_FILE="${HIVE_HOME_VAR%/}/conf/hive-site.xml"

if [[ ! -f "${CONFIG_HIVE_FILE}" ]]
then
  ## HIVE-20421
  cat "${CONFIG_HIVE_TEMPLATE}" |
    sed 's/&#8;/ /g' > "${CONFIG_HIVE_FILE}"
fi

########## HIVE UNPACK #########################################################
################################################################################
