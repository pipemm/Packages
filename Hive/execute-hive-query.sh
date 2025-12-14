#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

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
LogStdOut="${FolderOutput%/}/t.stdout.log"
LogStdErr="${FolderOutput%/}/t.stderr.log"
LogFile="${FolderOutput%/}/t.log"

FolderSQL='HiveQL/'
ls "${FolderSQL%/}/"*.sql |
  while read -r sql_file
  do
    sql_name="${sql_file##*/}"
    base_name="${sql_name%.sql}"
    TIMESTAMP=$(TZ=UTC date +%Y%m%d%H%M%S)
    csv_file="${PWD%/}/${FolderOutput%/}/${base_name}_${TIMESTAMP}.csv"
    echo "Executing ${sql_name} ..."
    hive-oneline "${sql_file}"  |
      tee \
        >( echo 'MD5(DATA) : '$( tail --lines='+2' | md5sum | sed 's/ .*//' ) ) \
        >( echo 'MD5       : '$(                     md5sum | sed 's/ .*//' ) ) \
        >( echo 'LINES     : '$( wc --lines                 | sed 's/ .*//' ) ) \
        > "${csv_file}"
    echo "Saved to ${csv_file}."
    sleep 0.01
  done |
  tee >(
    1> "${LogStdOut}" 2> "${LogStdErr}"
  ) >(
    1> "${LogFile}" 2>&1
  )


