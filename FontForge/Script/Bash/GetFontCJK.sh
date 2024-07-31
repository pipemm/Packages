

## https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-repository
DATE_CUT=$(TZ=UTC date --date='1 month ago' +'%Y-%m-%d')
API_RUNS="https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/runs?status=success&created=>2024-06-30"
#if [[ -z "${GITHUB_REPOSITORY_OWNER}" ]]
#then
#  GITHUB_REPOSITORY_OWNER="${GITHUB_REPOSITORY%%/*}"
#fi
API_RUNS="https://api.github.com/repos/${GITHUB_REPOSITORY_OWNER}/${GITHUB_REPOSITORY##*/}/actions/runs?status=success&created=>2024-06-30"

curl --location \
  --header "Accept: application/vnd.github+json" \
  --header "X-GitHub-Api-Version: 2022-11-28" \
  "${API_RUNS}" |
  jq '.workflow_runs' |
  jq 'sort_by(.updated_at) | reverse' |
  jq '[.[] | {path, updated_at, artifacts_url}]' |
  jq '[.[]|select(.path|endswith(".yaml"))]'

