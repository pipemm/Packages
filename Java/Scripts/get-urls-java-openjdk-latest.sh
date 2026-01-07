#!/usr/bin/bash

url_page='https://openjdk.org/projects/jdk/'

curl --silent --show-error --fail "${url_page}" |
  sed --silent '/(GA [0-9\/]\+)/p' |
  sed --silent 's!^.* href="\([0-9]\+\)\/".*$!\1!p' |
  while read -r ver
  do
    echo "${url_page%/}/${ver}/"
  done |
  head --lines=1 |
  while read -r urlp
  do
    curl --silent --show-error --fail "${urlp}" |
      sed --silent '/available from Oracle/p' |
      sed --silent 's! href="\([^"]\+\)"!\n\1\n!gp' |
      sed --silent '/^http[s]\?:\/\/jdk\.java\.net\/[0-9]\+$/p' |
      head --lines=1
  done |
  while read -r urlpg
  do
    curl --silent --show-error --fail --location "${urlpg}" |
      sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
      sed --silent '/^https:\/\/download\.java\.net\/java\/GA\/jdk/p'
  done
