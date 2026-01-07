#!/usr/bin/bash

## https://aws.amazon.com/corretto/
## https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/downloads-list.html

url_page='https://aws.amazon.com/corretto/'
corretto_version=$(
  curl --silent "${url_page}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p' |
  sed --silent 's!/downloads-list.html$!!p' |
  sed --silent 's!^.*/corretto-\([0-9]\+\)-ug$!\1!p' |
  sort --version-sort --reverse |
  head --lines=1
)
cpu_arch='x64'
host_os='linux'     ## 'linux'  'al2023'
package_type='jdk'  ## 'jdk'    'jre'
file_extension='tar.gz'

url_domain='https://corretto.aws/'
url_latest_original="${url_domain%/}/downloads/latest/amazon-corretto-${corretto_version}-${cpu_arch}-${host_os}-${package_type}.${file_extension}"

curl --silent --show-error --fail --head "${url_latest_original}" |
  sed --silent 's!^location: !!p' |
  head --lines=1 |
  while read -r url_file
  do
    echo "${url_domain%/}/${url_file#/}"
  done
