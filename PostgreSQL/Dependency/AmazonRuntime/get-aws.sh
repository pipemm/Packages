#!/usr/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

################################################################################

mvn_repo='https://repo1.maven.org/maven2/'
mvn_group_id='software.amazon.awssdk'
mvn_packaging='jar'

## https://github.com/aws/aws-sdk-java-v2/tree/master/http-client-spi/src/main/java

echo '
http-client-spi
identity-spi
regions
retries-spi
profiles
endpoints-spi
http-auth-spi
http-auth-aws
http-auth
auth
json-utils
third-party-jackson-core
' |
  sed '/^$/d' |
  while read -r mvn_artifact_id
  do
    query="g:${mvn_group_id}+AND+a:${mvn_artifact_id}+AND+p:${mvn_packaging}"
    url_api="https://search.maven.org/solrsearch/select?q=${query}&wt=json"
    curl "${url_api}" |
      jq --raw-output '.response.docs[0].latestVersion' |
      while read -r mvn_artifact_version
      do
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
            ## echo "${urldownload}"
          done
      done
  done
