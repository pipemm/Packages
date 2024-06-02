
url_domain='https://www.7-zip.org/'
url_page="${url_domain%/}/download.html"

url_package=$(
  curl "${url_page}" |
  sed --silent 's!^.*"\(.*7z.*-mac\.tar\.xz\)".*$!\1!p' |
  head --lines=1 |
  while read -r line
  do
    echo "${url_domain%/}/${line}"
  done
)

if [[ -z "${url_package}" ]]
then
  echo 'download link not found'
  echo 1
fi

folder_dl='package7z/'
mkdir --parent "${folder_dl%/}/"

echo "downloading ${url_package}"

echo "${url_package##*/}"

curl --output "${folder_dl%/}/${url_package##*/}" "${url_package}"

folder_7z='bin7z/'
mkdir --parent "${folder_7z%/}/"


