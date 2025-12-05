#!/usr/bin/bash

versionsed='/^stable\//'

## https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
## - http://www.apache.org/dyn/closer.cgi/hadoop/common/
## - https://dlcdn.apache.org/hadoop/common/
## - https://dlcdn.apache.org/hadoop/common/stable/
## - https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.4.2.tar.gz
## https://hadoop.apache.org/releases.html
URL_COMMON_PAGE='https://www.apache.org/dyn/closer.cgi/hadoop/common/'
curl --silent "${URL_COMMON_PAGE}" |
  sed '/Alternate download locations are suggested below\./q' |
  sed '0,/We suggest the following location for your download:/d' |
  sed --silent 's!^.* href="\(http[s]\?[^"]\+\)".*$!\1!p' |
  head --lines=1 |
  while read -r url0
  do
    curl --silent "${url0}" |
      sed --silent 's!^.*href="\([^"]\+/\)".*$!\1!p' |
      sed --silent "${versionsed}p" |
      sort --reverse --version-sort |
      while read -r url1
      do
        echo "${url0%/}/${url1#/}"
      done
  done |
  head --lines=1 |
  while read -r url2
  do
    curl --silent "${url2}" |
      sed --silent 's!^.*href="\(hadoop-[^"]\+\)".*$!\1!p' |
      while read -r url3
      do
        echo "${url2%/}/${url3#/}"
      done
  done


