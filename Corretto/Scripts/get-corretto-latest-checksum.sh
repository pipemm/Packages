#!/usr/bin/bash

## https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/downloads-list.html

corretto_version=17
cpu_arch='x64'
host_os='linux'     ## 'linux'  'al2023'
package_type='jdk'  ## 'jdk'    'jre'
file_extension='tar.gz'

checksum="${1,,}"
if [[ "${checksum}" != 'sha256' ]]
then
  checksum='checksum'
fi

url_domain='https://corretto.aws/'
url_latest_checksum="${url_domain%/}/downloads/latest_${checksum}/amazon-corretto-${corretto_version}-${cpu_arch}-${host_os}-${package_type}.${file_extension}"

curl --silent "${url_latest_checksum}"
