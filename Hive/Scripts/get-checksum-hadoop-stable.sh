#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

url0=$(bash 'get-url-hadoop-stable.sh')
if [[ -z "${url0}" ]]
then 
  exit 1
fi

url="${url0}.sha512"
echo "${url}"

curl --silent "${url}" |
  sed 's!^.*[ ]*=[ ]*!!p' |
  sed 's![ ]\+hadoop[^ ]*$!!p' |
  head --lines=1

