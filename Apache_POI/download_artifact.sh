
url_mvn='https://search.maven.org/remotecontent'
path_artifact="${1}"

if [[ -z "${path_artifact}" ]]
then
  exit 0
fi

folder_download=${folder_download:-local_download/}
folder_log=${folder_log:-local_log/}

echo "check ${path_artifact}"
echo "${folder_download}"
echo "${folder_log}"

url_artifact="${url_mvn}?filepath=${path_artifact}"
file_artifact="${url_artifact##*/}"

echo "download ${url_artifact}"

curl --location "${url_artifact}" |
  tee >(
    md5sum    | sed 's/ .*//' > "${folder_log%/}/pipe_${file_artifact}.md5"
  ) >(
    sha1sum   | sed 's/ .*//' > "${folder_log%/}/pipe_${file_artifact}.sha1"
  ) >(
    sha256sum | sed 's/ .*//' > "${folder_log%/}/pipe_${file_artifact}.sha256"
  ) >(
    sha512sum | sed 's/ .*//' > "${folder_log%/}/pipe_${file_artifact}.sha512"
  ) > "${folder_download%/}/${file_artifact}"
