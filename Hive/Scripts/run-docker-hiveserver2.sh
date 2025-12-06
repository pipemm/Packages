#!/usr/bin/bash

## https://hive.apache.org/development/quickstart/
## - https://hub.docker.com/r/apache/hive/tags
## https://github.com/apache/hive/blob/master/packaging/src/docker/entrypoint.sh
## - https://github.com/apache/hive/blob/master/packaging/src/docker/build.sh

HIVE_VERSION='3.1.3'
IMAGE_NAME_TAG="apache/hive:${HIVE_VERSION}"
CONTAINER_NAME='hive3'

docker run --detach \
  --publish 10000:10000 --publish 10002:10002 \
  --env SERVICE_NAME=hiveserver2 \
  --name "${CONTAINER_NAME}" "${IMAGE_NAME_TAG}"

docker ps

docker logs "${CONTAINER_NAME}"

