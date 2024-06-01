
url_domain='https://www.7-zip.org/'
url_page='https://www.7-zip.org/download.html'

curl "${url_page}" |
  sed --silent 's!^.*"\(.*7z.*-mac\.tar\.xz\)".*$!\1!p' |
  head --lines=1 |
  while read -r line
  do
    echo "${url_domain%/}/${line}"
  done