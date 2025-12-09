#!/usr/bin/bash

## https://adoptium.net/en-GB/temurin/releases
## https://api.adoptium.net/q/swagger-ui/
url_api_server='https://api.adoptium.net/'
url_api_releases="${url_api_server%/}/v3/info/available_releases"
jvm_impl='hotspot'

curl --silent --show-error --fail --retry 3 --retry-delay 2 "${url_api_releases}" |
  jq --raw-output '.available_lts_releases | sort_by(.) | reverse | .[]' |
  head --lines=1 |
  while read -r feature_version
  do
    url_api_assets="${url_api_server%/}/v3/assets/latest/${feature_version}/${jvm_impl}"
    curl --silent --show-error --fail --retry 3 --retry-delay 2 "${url_api_assets}" |
      jq '[.[].binary]' |
      jq '[.[] | select(.os | IN("linux", "windows", "mac"))]' |
      jq '[.[] | select(.image_type | IN("jdk", "jre"))]' |
      jq '[.[] | select(.architecture == "x64")]' |
      jq '[.[] | {arch:.architecture,image_type,os,checksum:.package.checksum,checksum_link:.package.checksum_link,link:.package.link,name:.package.name}]' |
      jq --raw-output '.[] | .link, .checksum_link'
  done
