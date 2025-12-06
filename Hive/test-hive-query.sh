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

FolderOutput='TestOutput/'
mkdir --parent "${FolderOutput%/}/"

FolderSQL='HiveQL/'
ls "${FolderSQL%/}/"*.sql |
  while read -r sql_file
  do
    sql_name="${sql_file##*/}"
    echo "Executing ${sql_name} ..."
    base_name="${sql_name%.sql}"
    TIMESTAMP=$(TZ=UTC date +%Y%m%d%H%M%S)
    csv_file="${PWD%/}/${FolderOutput%/}/${base_name}_${TIMESTAMP}.csv"
    hive-oneline "${sql_file}" > "${csv_file}"
    echo "Saved to ${csv_file}."
    wc --lines "${csv_file}"
    md5sum "${csv_file}"
  done


