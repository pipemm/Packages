#!/usr/bin/bash

## https://hive.apache.org/development/quickstart/
## https://hub.docker.com/r/apache/hive/tags
## https://hub.docker.com/r/apache/hive/tags

HIVE_VERSION='3.1.3'

##docker pull "${HIVE_VERSION}"

docker run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hive4 apache/hive:${HIVE_VERSION}
