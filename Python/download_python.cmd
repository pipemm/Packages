
IF DEFINED FILE_NAME (
  echo FILE_NAME=%FILE_NAME%
) ELSE (
  echo FILE_NAME not defined
  exit 1
)

IF DEFINED URL_DONWLOAD (
  echo URL_DONWLOAD=%URL_DONWLOAD%
) ELSE (
  echo URL_DONWLOAD not defined
  exit 1
)


SET "FOLDER_PYTHON=Python\"

mkdir "%FOLDER_PYTHON%"
curl --output "%FOLDER_PYTHON%\%FILE_NAME%" "%URL_DONWLOAD%"
dir "%FOLDER_PYTHON%"

