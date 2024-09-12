#!/usr/bin/bash

FOLDER_DL='Download/'
mkdir --parent "${FOLDER_DL%/}/"

FILE_URL0="${FOLDER_DL%/}/URL0.txt"

## https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
## - http://www.apache.org/dyn/closer.cgi/hadoop/common/
URL_COMMON='https://www.apache.org/dyn/closer.cgi/hadoop/common/'
curl "${URL_COMMON}" |
  sed '/Alternate download locations are suggested below\./q' |
  sed '0,/We suggest the following location for your download:/d' |
  sed --silent 's!^.*"\(http[s]\?[^"]\+\)".*$!\1!p' > "${FILE_URL0}"

cat "${FILE_URL0}"

