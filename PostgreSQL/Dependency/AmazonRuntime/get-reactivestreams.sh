#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

################################################################################

mvn_group_id='org.reactivestreams'
mvn_artifact_id='reactive-streams'
mvn_packaging='jar'
query="g:${mvn_group_id}+AND+a:${mvn_artifact_id}+AND+p:${mvn_packaging}"

url_api="https://search.maven.org/solrsearch/select?q=${query}&core=gav&wt=json"
mvn_artifact_version=$(
  curl "${url_api}" |
  jq  --raw-output '.response.docs[].v' |
  sed '/[^0-9.]/d' |
  head --lines=1
)

mvn_repo='https://repo1.maven.org/maven2/'
url_page="${mvn_repo%/}/${mvn_group_id//.//}/${mvn_artifact_id}/${mvn_artifact_version}/"
curl "${url_page}" |
  sed --silent 's!^.*href="\([^"]*\).*$!\1!p' |
  tee >(
    sed --silent "/^${mvn_artifact_id}-${mvn_artifact_version}.jar$/p" |
    while read -r jarfile
    do
      if [[ ! -f "${jarfile}" ]]
      then
        urldownload="${url_page%/}/${jarfile}"
        curl --output "${jarfile}" "${urldownload}"
      fi
    done
  ) |
  sed --silent "/^${mvn_artifact_id}-${mvn_artifact_version}.pom$/p" |
  while read -r pomfile
  do
    urldownload="${url_page%/}/${pomfile}"
  done

################################################################################
