#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

HADOOP_HOME_VAR=$(bash get-home-hadoop.sh)
HIVE_HOME_VAR=$(bash get-home-hive.sh)

echo "${PATH}:${HIVE_HOME_VAR%/}/bin:${HADOOP_HOME_VAR%/}/bin"
