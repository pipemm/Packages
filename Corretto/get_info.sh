
FOLDER_LOG='01_log/'
mkdir --parent "${FOLDER_LOG%/}/"

API_ENDPOINT='https://api.github.com/'

URL_REPOS="${API_ENDPOINT%/}/orgs/corretto/repos?type=public"
FILE_REPOS="${FOLDER_LOG%/}/repos_stdout.log"

curl --location \
  --header 'Accept: application/vnd.github+json' \
  --header 'X-GitHub-Api-Version: 2022-11-28' \
  "${URL_REPOS}" |
  jq '[.[] | select(.archived == false)]' |
  jq '[.[] | select(.private  == false)]' |
  jq '[.[] | select(.disabled == false)]' |
  jq '[.[] | select(.visibility == "public")]' |
  jq '[.[] | {id:.id, name:.name, full_name:.full_name}]' |
  jq '[.[] | select(.name|startswith("corretto-"))]' |
  jq --raw-output '.[] | [.name, .id, .full_name] | @csv' |
  sed --silent '/^"corretto-[0-9]*"/p' |
  sed --silent 's/^.*"\([^"]\+\)"$/\1/p' > "${FILE_REPOS}"

FILE_RELEASE_LATEST="${FOLDER_LOG%/}/releaselatest_stdout.log"

cat "${FILE_REPOS}" |
  while read -r o_repo
  do
    URL_RELEASE="${API_ENDPOINT%/}/repos/${o_repo}/releases/latest"
    version="${o_repo##*corretto-}"
    info=$(curl --location \
           --header 'Accept: application/vnd.github+json' \
           --header 'X-GitHub-Api-Version: 2022-11-28' \
           "${URL_RELEASE}" |
           jq --raw-output '[.id, .name, .tag_name] | @csv' |
           sed --silent '/^[0-9]\+/p'
          )
    release_id="${info%%,*}"
    if [[ -n "${release_id}" ]]
    then
      echo "${version}|TYPE_ID|${release_id}"
    fi
    tag="${info##*,}"
    if [[ -n "${tag}" ]]
    then
      echo "${version}|TYPE_TAG|${tag}"
    fi
  done > "${FILE_RELEASE_LATEST}"

