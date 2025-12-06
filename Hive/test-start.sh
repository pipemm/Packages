#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

HADOOP_HOME_VAR=$(bash get-home-hadoop.sh)
HIVE_HOME_VAR=$(bash get-home-hive.sh)

PATH="${PATH}:${HIVE_HOME_VAR%/}/bin/:${HADOOP_HOME_VAR%/}/bin/"

FolderWork='TestDir/'
mkdir --parent "${FolderWork%/}/"

schematool --help

schematool -dbType derby -initSchema

##hive --service metastore



##hive --service hiveserver2 --hiveconf hive.root.logger=TRACE,console

