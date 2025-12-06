#!/usr/bin/bash

## https://docs.docker.com/reference/api/hub/latest/#tag/repositories/operation/ListRepositoryTags

HIVE_VERSION=$(
  url_page='https://hub.docker.com/v2/namespaces/apache/repositories/hive/tags'
  while true
  do
    url_page_next=$(
      curl "${url_page}" |
      jq --raw-output '.next'
    )
    curl "${url_page}" |
      jq --raw-output '.results[].name'
    url_page="${url_page_next}"
    if [[ "${url_page}" == 'null' ]]
    then
      break
    fi
  done |
    sed --silent '/^[0-9.]\+$/p' |
    sort --reverse --version-sort |
    head --lines=1
)



## https://hive.apache.org/development/quickstart/
## - https://hub.docker.com/r/apache/hive/tags
## https://github.com/apache/hive/blob/master/packaging/src/docker/entrypoint.sh
## - https://github.com/apache/hive/blob/master/packaging/src/docker/build.sh

IMAGE_NAME_TAG="apache/hive:${HIVE_VERSION}"
CONTAINER_NAME='hive'

docker run --detach \
  --publish 10000:10000 --publish 10002:10002 \
  --env SERVICE_NAME=hiveserver2 \
  --name "${CONTAINER_NAME}" "${IMAGE_NAME_TAG}"

docker ps

ss --tcp --udp --listening --numeric

docker logs "${CONTAINER_NAME}"

