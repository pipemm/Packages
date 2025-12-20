#!/usr/bin/bash

## https://aws.amazon.com/corretto/
## https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/downloads-list.html

url_page='https://aws.amazon.com/corretto/'
curl --silent "${url_page}" |
  sed --silent 's!^.* href="\([^"]\+\)".*$!\1!p'
