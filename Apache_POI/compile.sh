
folder_class='local_class/'
mkdir --parent "${folder_class%/}/"

CLASSPATH='.'
for jar in ${PWD%/}/local_jar/*.jar
do
    CLASSPATH="${CLASSPATH}:${jar}"
done

javac --class-path "${CLASSPATH}" -d "${folder_class%/}/" script_java/*.java

