#!/usr/bin/bash

## https://adoptium.net/en-GB/temurin/releases
## https://api.adoptium.net/q/swagger-ui/
url_api_server='https://api.adoptium.net/'
url_api_versions='https://api.adoptium.net/v3/info/available_releases'

curl "${url_api_versions}" |
  jq --raw-output '.available_releases | sort_by(.) | reverse | .[]' |
  head --lines=1 |
  while read -r feature_version
  do
    echo "${feature_version}"
  done
