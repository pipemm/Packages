#!/usr/bin/bash

hive-query() {
  local sql_query="$1"
  env HADOOP_CLIENT_OPTS='-Ddisable.quoting.for.sv=false' beeline \
    -u 'jdbc:hive2://localhost:10000/' \
    --outputformat=csv2 --showHeader=true --nullemptystring=true \
    --hivevar hive.resultset.use.unique.column.names=false \
    --silent=false \
    -e "${sql_query}"
}

hive-stdin() {
  env HADOOP_CLIENT_OPTS='-Ddisable.quoting.for.sv=false' beeline \
    -u 'jdbc:hive2://localhost:10000/' \
    --outputformat=csv2 --showHeader=true --nullemptystring=true \
    --hivevar hive.resultset.use.unique.column.names=false \
    --silent=false
}

hive-query 'SHOW FUNCTIONS;' |
  tail --lines='+2' |
  while read -r function_name
  do
    function_name="${function_name^^}"
    query_describe_1="DESCRIBE FUNCTION \`${function_name}\`;"
    query_describe_2="DESCRIBE FUNCTION EXTENDED \`${function_name}\`;"
    echo "${query_describe_2}"
  done |
  hive-stdin |
  sed 's/^tab_name$/--------------------------------------------------------------------------------/' |
  sed 's/^"\(.*\)"$/\1/'


