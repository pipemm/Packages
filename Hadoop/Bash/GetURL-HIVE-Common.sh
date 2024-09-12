#!/usr/bin/bash

## https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
## - http://www.apache.org/dyn/closer.cgi/hadoop/common/
URL_COMMON='https://www.apache.org/dyn/closer.cgi/hadoop/common/'
curl "${URL_COMMON}" |
  sed '/Alternate download locations are suggested below\./q'

