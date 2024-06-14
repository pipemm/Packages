

CLASSPATH='.'
for jar in ${PWD%/}/local_jar/*.jar
do
    CLASSPATH="${CLASSPATH}:${jar}"
done

javac --class-path "${CLASSPATH}" 'script_java/NewWorkbook.java'

cd script_java

java  --class-path "${CLASSPATH}"  NewWorkbook newname.xlsx