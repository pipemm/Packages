
thisscript=$(realpath "${0}")
thispath="${thisscript%/*}/"
cd "${thispath}"

folder_dl='package7z/'

folder_7z='bin7z/'
mkdir --parent "${folder_7z%/}/"

file_package=$(ls "${folder_dl%/}"/*.tar.xz)

if [[ -z "${file_package}" ]]
then
  echo 'package not found'
  echo 1
fi

tar --extract --xz --file="${file_package}" --directory="${folder_7z%/}/"
