
url_page='https://poi.apache.org/download.html'
target_artifact='poi-ooxml'  ## 'poi-ooxml-lite' 'poi-ooxml' 'poi-ooxml-full'

folder_jar='local_jar/'
mkdir --parent "${folder_jar%/}/"
folder_log='local_log/'
mkdir --parent "${folder_log%/}/"

url_artifacts=$(
  curl "${url_page}" |
  sed --silent 's!^.* href="\(https://[a-z0-9.]*maven.org/maven2/org/apache/poi/\)".*$!\1!p' |
  head --lines=1
)

verion=$(
curl "${url_artifacts%/}/${target_artifact}/" |
  sed --silent 's!^.* href="\([0-9]\+[.][0-9]\+[.][0-9]\+\)/".*$!\1!p' |
  sort --reverse --version-sort |
  head --lines=1
)

url_jar="${url_artifacts%/}/${target_artifact}/${verion}/${target_artifact}-${verion}.jar"
file_jar="${url_jar##*/}"

echo "download ${url_jar}"

curl "${url_jar}" |
  tee >(
    md5sum    | sed 's/ .*//' > "${folder_log%/}/${file_jar}.md5"
  ) >(
    sha1sum   | sed 's/ .*//' > "${folder_log%/}/${file_jar}.sha1"
  ) >(
    sha256sum | sed 's/ .*//' > "${folder_log%/}/${file_jar}.sha256"
  ) >(
    sha512sum | sed 's/ .*//' > "${folder_log%/}/${file_jar}.sha512"
  ) > "${folder_jar%/}/${file_jar}"

echo
echo 'compare md5'
echo $(curl --silent "${url_jar}.md5")
cat "${folder_log%/}/${file_jar}.md5"
md5sum    "${folder_jar%/}/${file_jar}" | sed 's/ .*//'

echo
echo 'compare sha1'
echo $(curl --silent "${url_jar}.sha1")
cat "${folder_log%/}/${file_jar}.sha1"
sha1sum   "${folder_jar%/}/${file_jar}" | sed 's/ .*//'

echo
echo 'compare sha256'
echo $(curl --silent "${url_jar}.sha256")
cat "${folder_log%/}/${file_jar}.sha256"
sha256sum "${folder_jar%/}/${file_jar}" | sed 's/ .*//'

echo
echo 'compare sha512'
echo $(curl --silent "${url_jar}.sha512")
cat "${folder_log%/}/${file_jar}.sha512"
sha512sum "${folder_jar%/}/${file_jar}" | sed 's/ .*//'

folder_python='python_script/'
py_pom="${folder_python%/}/read_pom_dependencies.py"

url_mvn='https://mvnrepository.com/artifact/'
url_pom="${url_artifacts%/}/${target_artifact}/${verion}/${target_artifact}-${verion}.pom"
curl "${url_pom}" |
  python3 "${py_pom}" |
  while read -r artifact_path
  do
    url_artifact="${url_mvn%/}/${artifact_path}"
    echo "check ${url_artifact}"
    
  done
