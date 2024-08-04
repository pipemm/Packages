

## https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-repository
DATE_CUT=$(TZ=UTC date --date='2 month ago' +'%Y-%m-%d')
if [[ -z "${REPOSITORY_FROM}" ]]
then
  REPOSITORY_FROM="${GITHUB_REPOSITORY}"
fi
API_RUNS="https://api.github.com/repos/${REPOSITORY_FROM}/actions/runs?status=success&created=>${DATE_CUT}"

curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${API_RUNS}" |
  jq '.workflow_runs' |
  jq 'sort_by(.updated_at) | reverse' |
  jq '[.[] | {path, updated_at, artifacts_url}]' |
  jq '[.[]|select(.path|endswith(".yaml"))]' |
  jq --raw-output '.[] | .artifacts_url' |
  while read -r url
  do
    ## https://docs.github.com/en/rest/actions/artifacts?apiVersion=2022-11-28#list-artifacts-for-a-repository
    response=$(
      curl --location \
      --header 'Accept: application/vnd.github+json' \
      --header 'X-GitHub-Api-Version: 2022-11-28' \
      "${url}"
    )
    total_count=$(
      echo "${response}" |
      jq '.total_count'
    )
    if [[ ${total_count} -gt 0 ]] 
    then
      echo "${url}"
      echo "${response}"
      if [[ -n "${GITHUB_ENV}" ]]
      then
        ARTIFACT_RUN_ID="${url%/artifacts}"
        ARTIFACT_RUN_ID="${ARTIFACT_RUN_ID##*/}"
        echo "ARTIFACT_RUN_ID=${ARTIFACT_RUN_ID}"
        echo "ARTIFACT_RUN_ID=${ARTIFACT_RUN_ID}" >> "${GITHUB_ENV}"
      fi
      break
    fi
  done

