#!/usr/bin/bash

versionsed="/^hive-3\.1\.3\/$/"

## https://archive.apache.org/dist/hive/
URL_ARCHIVE_PAGE='https://archive.apache.org/dist/hive/'
curl --silent "${URL_ARCHIVE_PAGE}" |
  sed --silent 's!^.* href="\([^"]\+/\)".*$!\1!p' |
  sed --silent "/^hive-[0-9.]\+\/$/p" |
  sed --silent "${versionsed}p" |
  sort --reverse --version-sort |
  while read -r hversion
  do
    echo "${URL_ARCHIVE_PAGE%/}/${hversion#/}"
  done |
  head --lines=1 |
  while read -r urlpage
  do
    curl --silent "${urlpage}" |
      sed --silent 's!^.* href="\(apache-hive-[^"]\+\)".*$!\1!p' |
      while read -r finename
      do
        echo "${urlpage%/}/${finename#/}"
      done
  done |
  sed --silent '/apache-hive-[0-9.]\+-bin.tar.gz$/p' |
  head --lines=1



