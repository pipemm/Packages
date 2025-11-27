#!/usr/bin/bash

curl --silent https://maven.apache.org/download.cgi |
  sed --silent 's!^.* href="\(https://[^"]\+\)".*$!\1!p' |
  sed --silent '/\/binaries\/apache-maven-[0-9.]\+-bin/p'

