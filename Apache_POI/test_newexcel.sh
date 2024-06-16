
folder_class='local_class/'
mkdir --parent "${folder_class%/}/"
folder_xlsx='local_xlsx/'
mkdir --parent "${folder_xlsx%/}/"

CLASSPATH='.'
for jar in ${PWD%/}/local_jar/*.jar
do
    CLASSPATH="${CLASSPATH}:${jar}"
done

CLASSPATH="${CLASSPATH}:${folder_class%/}/"

java  --class-path "${CLASSPATH}"  NewWorkbook "${folder_xlsx%/}/New Microsoft Excel Worksheet.xlsx"

zipinfo -vh "${folder_xlsx%/}/*.xlsx"

ls ${folder_xlsx%/}/*.{xlsx,xlsm} |
  while read -r xlsxfile
  do
    echo "checking ${xlsxfile}"
    java --class-path "${CLASSPATH}"  EncryptionInformation "${xlsxfile}"
  done
