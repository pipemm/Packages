#!/usr/bin/bash

url_releases='https://www.scala-lang.org/download/all.html'

curl --silent --show-error --fail "${url_releases}" |
  sed --silent 's!^.*>Scala \([0-9.]\+\)\( LTS\)</a>.*$!\1!p' |
  sort --reverse --version-sort |
  head --lines=1

