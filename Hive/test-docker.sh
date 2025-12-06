#!/usr/bin/bash

## https://hive.apache.org/development/quickstart/
## - https://hub.docker.com/r/apache/hive/tags
## https://github.com/apache/hive/blob/master/packaging/src/docker/entrypoint.sh
## - https://github.com/apache/hive/blob/master/packaging/src/docker/build.sh

HIVE_VERSION='3.1.3'
IMAGE_NAME="apache/hive:${HIVE_VERSION}"
CONTAINER_NAME='hive3'

docker run --detach \
  --publish 10000:10000 --publish 10002:10002 \
  --env SERVICE_NAME=hiveserver2 \
  --name hive3 apache/hive:${HIVE_VERSION}

docker ps

docker logs "${CONTAINER_NAME}"
