
FolderJava='Script/Java/'
FileList="${FolderJava%/}/CompileList.txt"

if [[ ! -f "${FileList}" ]]
then
  echo 'compile list not found' 1>&2
  exit 0
fi

FolderClass='Class/'
mkdir --parent "${FolderClass%/}/"

FolderSDK='DevelopmentKit/'
CLASSPATH='.'
for j in ${PWD%/}/${FolderSDK%/}/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
CLASSPATH="$CLASSPATH:${PWD%/}/${FolderClass%/}/"

cat "${FileList}" |
  while read -r line
  do
    JavaPath="${line%.java}.java"
    JavaPath="${FolderJava%/}/${JavaPath#/}"
    if [[ ! -f "${JavaPath#/}" ]]
    then
      continue
    fi
    echo "compiling ${line}"
    javac -d "${FolderClass%/}/" --class-path "${CLASSPATH}" "${JavaPath}"
  done

java --class-path "${CLASSPATH}" demo.Tester
