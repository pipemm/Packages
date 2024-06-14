
url_mvn='https://search.maven.org/remotecontent'
path_artifact="${1}"

if [[ -z "${path_artifact}" ]]
then
  exit 0
fi

folder_download=${folder_download:-local_download/}
folder_log=${folder_log:-local_log/}


url_artifact="${url_mvn}?filepath=${path_artifact}"
file_artifact="${path_artifact##*/}"

if [[ -z "${file_artifact}" ]]
then
  echo 'no file to download'
  exit 0
fi

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

##################################################
algorithm='md5'
url_checksum="${url_artifact}.${algorithm}"
utility_checksum="${algorithm}sum"
file_checksum="${file_artifact}.${algorithm}"
curl --location --fail --silent --output "${folder_log%/}/${file_checksum}" "${url_checksum}"

echo
echo "compare ${algorithm}"
"${utility_checksum}" "${folder_download%/}/${file_artifact}" | sed 's/ .*//'
echo $(cat "${folder_log%/}/pipe_${file_artifact}.${algorithm}")
if [[ -f "${folder_log%/}/${file_checksum}" ]]
then
  echo $(cat "${folder_log%/}/${file_checksum}")
fi

##################################################
algorithm='sha1'
url_checksum="${url_artifact}.${algorithm}"
utility_checksum="${algorithm}sum"
file_checksum="${file_artifact}.${algorithm}"
curl --location --fail --silent --output "${folder_log%/}/${file_checksum}" "${url_checksum}"

echo
echo "compare ${algorithm}"
"${utility_checksum}" "${folder_download%/}/${file_artifact}" | sed 's/ .*//'
echo $(cat "${folder_log%/}/pipe_${file_artifact}.${algorithm}")
if [[ -f "${folder_log%/}/${file_checksum}" ]]
then
  echo $(cat "${folder_log%/}/${file_checksum}")
fi

##################################################
algorithm='sha256'
url_checksum="${url_artifact}.${algorithm}"
utility_checksum="${algorithm}sum"
file_checksum="${file_artifact}.${algorithm}"
curl --location --fail --silent --output "${folder_log%/}/${file_checksum}" "${url_checksum}"

echo
echo "compare ${algorithm}"
"${utility_checksum}" "${folder_download%/}/${file_artifact}" | sed 's/ .*//'
echo $(cat "${folder_log%/}/pipe_${file_artifact}.${algorithm}")
if [[ -f "${folder_log%/}/${file_checksum}" ]]
then
  echo $(cat "${folder_log%/}/${file_checksum}")
fi

##################################################
algorithm='sha512'
url_checksum="${url_artifact}.${algorithm}"
utility_checksum="${algorithm}sum"
file_checksum="${file_artifact}.${algorithm}"
curl --location --fail --silent --output "${folder_log%/}/${file_checksum}" "${url_checksum}"

echo
echo "compare ${algorithm}"
"${utility_checksum}" "${folder_download%/}/${file_artifact}" | sed 's/ .*//'
echo $(cat "${folder_log%/}/pipe_${file_artifact}.${algorithm}")
if [[ -f "${folder_log%/}/${file_checksum}" ]]
then
  echo $(cat "${folder_log%/}/${file_checksum}")
fi

