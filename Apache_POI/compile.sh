
folder_class='local_class/'
mkdir --parent "${folder_class%/}/"
folder_xlsx='local_xlsx/'
mkdir --parent "${folder_xlsx%/}/"

CLASSPATH='.'
for jar in ${PWD%/}/local_jar/*.jar
do
    CLASSPATH="${CLASSPATH}:${jar}"
done

javac --class-path "${CLASSPATH}" -d "${folder_class%/}/" 'script_java/NewWorkbook.java'

CLASSPATH="${CLASSPATH}:${folder_class%/}/"

java  --class-path "${CLASSPATH}"  NewWorkbook "${folder_xlsx%/}/newname.xlsx"
