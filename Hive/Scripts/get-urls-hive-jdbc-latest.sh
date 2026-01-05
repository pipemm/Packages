#!/usr/bin/bash

sedversion='/^[0-9.]\+$/'

## shifting away from legacy Search API to using CDN
## https://status.maven.org/
## https://mvnrepository.com/artifact/org.apache.hive/hive-jdbc

curl_silent='curl --silent --show-error --fail --retry 3 --retry-delay 2 '

url_maven='https://repo1.maven.org/maven2/org/apache/hive/hive-jdbc/'
${curl_silent} "${url_maven}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
  sed --silent 's!^\([0-9]\+[0-9.]*\)/$!\1!p' |
  sed --silent "${sedversion}p" |
  sort --version-sort --reverse |
  head --lines=1 |
  while read -r version
  do
    echo "${url_maven%/}/${version}/"
  done |
  while read -r url_prefix
  do
    ${curl_silent} "${url_prefix}"  |
      sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
      sed '/\/$/d' |
      while read -r file_name
      do
        echo "${url_prefix%/}/${file_name}"
      done      
  done

  
