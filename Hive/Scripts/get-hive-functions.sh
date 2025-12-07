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

hive-query 'SHOW FUNCTIONS;' |
  tail --lines='+2'


