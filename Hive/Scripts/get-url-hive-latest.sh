#!/usr/bin/bash

## http://www.apache.org/dyn/closer.cgi/hive/
## - https://dlcdn.apache.org/hive/
## - https://dlcdn.apache.org/hive/hive-4.2.0/apache-hive-4.2.0-bin.tar.gz
URL_DOWNLOAD_PAGE='https://www.apache.org/dyn/closer.cgi/hive/'
curl --silent "${URL_DOWNLOAD_PAGE}" |
  sed '/Alternate download locations are suggested below\./q' |
  sed '0,/We suggest the following location for your download:/d' |
  sed --silent 's!^.* href="\(http[s]\?[^"]\+\)".*$!\1!p' |
  head --lines=1 |
  while read -r url0
  do
    curl --silent "${url0}" |
      sed --silent 's!^.* href="\([^"]\+/\)".*$!\1!p' |
      sed --silent "/^hive-[0-9.]\+\/$/p" |
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
      sed --silent 's!^.* href="\(apache-hive-[^"]\+\)".*$!\1!p' |
      while read -r url3
      do
        echo "${url2%/}/${url3#/}"
      done
  done |
  sed --silent '/apache-hive-[0-9.]\+-bin\.tar\.gz$/p' |
  head --lines=1
