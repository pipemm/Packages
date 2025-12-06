#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

HADOOP_HOME_VAR=$(bash get-home-hadoop.sh)
HIVE_HOME_VAR=$(bash get-home-hive.sh)

PATH="${PATH}:${HIVE_HOME_VAR%/}/bin/:${HADOOP_HOME_VAR%/}/bin/"

FolderWork='TestDir/'
if [[ -d "${FolderWork%/}/" ]]
then
  rm --recursive --force "${FolderWork%/}/"
fi
mkdir --parent "${FolderWork%/}/"
cd "${FolderWork%/}/"

schematool -dbType derby -initSchema
hive --service metastore > hive-metastore.log 2>&1 &

hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000 --hiveconf hive.root.logger=DEBUG,console

