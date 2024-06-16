
url_page='https://poi.apache.org/download.html'
target_artifact='poi-ooxml'  ## 'poi-ooxml-lite' 'poi-ooxml' 'poi-ooxml-full'

folder_jar='local_jar/'
mkdir --parent "${folder_jar%/}/"
folder_log='local_log/'
mkdir --parent "${folder_log%/}/"
folder_shell='script_shell/'
sh_dla="${folder_shell%/}/download_artifact.sh"

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
url_pom="${url_artifacts%/}/${target_artifact}/${verion}/${target_artifact}-${verion}.pom"

echo "checkout ${url_jar}"

export folder_download="${folder_jar}"
export folder_log="${folder_log}"
bash "${sh_dla}" "${url_jar}"

export folder_download="${folder_log}"
export folder_log="${folder_log}"
bash "${sh_dla}" "${url_pom}"

folder_python='script_python/'
py_pom="${folder_python%/}/read_pom_dependencies.py"

file_pom="${url_pom##*/}"
cat "${folder_log%/}/${file_pom}" |
  python3 "${py_pom}" |
  while read -r artifact_path
  do
    echo
    echo "check ${artifact_path}"
    export folder_download="${folder_jar}"
    export folder_log="${folder_log}"
    bash "${sh_dla}" "${artifact_path}"
  done
