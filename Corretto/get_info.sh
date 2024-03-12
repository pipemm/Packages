
URL_REPOS='https://api.github.com/orgs/corretto/repos?type=public'

curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${URL_REPOS}" |
  jq '[.[] | select(.archived == false)]' |
  jq '[.[] | select(.private  == false)]' |
  jq '[.[] | select(.disabled == false)]' |
  jq '[.[] | select(.visibility == "public")]' |
  jq '[.[] | {id:.id, name:.name, full_name:.full_name}]' |
  jq '[.[] | select(.name|startswith("corretto-"))]'
  ##jq '[.[] | select(.archived == false)]'
