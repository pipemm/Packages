
DATE_CUT=$(TZ=UTC date --date='1 month ago' +'%Y-%m-%d')
API_RUNS="https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/runs?status=success&created=>2024-06-30"
if [[ -z "${GITHUB_REPOSITORY_OWNER}" ]]
then
  GITHUB_REPOSITORY_OWNER="${GITHUB_REPOSITORY%%/*}"
fi
API_RUNS="https://api.github.com/repos/${GITHUB_REPOSITORY_OWNER}/${GITHUB_REPOSITORY##*/}/actions/runs?status=success&created=>2024-06-30"

curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "${API_RUNS}"

