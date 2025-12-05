#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

url0=$(bash 'get-url-hive-latest.sh')
if [[ -z "${url0}" ]]
then 
  exit 1
fi

url="${url0}.sha256"

curl --silent "${url}" |
  sed 's!^.*[ ]*=[ ]*!!p' |
  sed 's![ ]\+apache-hive[^ ]*$!!p' |
  head --lines=1

