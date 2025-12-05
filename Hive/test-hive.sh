#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

HADOOP_HOME_VAR=$(bash get-home-hadoop.sh)
HIVE_HOME_VAR=$(bash get-home-hive.sh)

PATH="${PATH}:${HIVE_HOME_VAR%/}/bin/:${HADOOP_HOME_VAR%/}/bin/"

beeline --version

hive-oneline() {
  local sqlfile="$1"
  env HADOOP_CLIENT_OPTS='-Ddisable.quoting.for.sv=false' beeline \
    -u 'jdbc:hive2://localhost:10000/' \
    --outputformat=csv2 --showHeader=true --nullemptystring=true \
    --hivevar hive.resultset.use.unique.column.names=false \
    --silent=false \
    -f "${sqlfile}"
}


FolderSQL='HiveSQL/'
ls "${FolderSQL%/}/"*.sql |
  while read -r SQLFile
  do
    echo "Executing ${SQLFile##*/} ..."
    hive-oneline "${SQLFile}"
  done

