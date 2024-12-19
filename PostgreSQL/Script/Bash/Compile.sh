#!/usr/bin/bash

FolderJava='Script/Java/'
FileList="${FolderJava%/}/CompileList.txt"

if [[ ! -f "${FileList}" ]]
then
  echo 'compile list not found' 1>&2
  exit 0
fi

FolderClass='Class/'
mkdir --parent "${FolderClass%/}/"
CLASSPATH="${FolderClass%/}/"

FolderSDK='DevelopmentKit/'
for j in ${PWD%/}/${FolderSDK%/}/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
for j in ${PWD%/}/Dependency/**/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done


cat "${FileList}" |
  while read -r line
  do
    JavaPath="${line%.java}.java"
    JavaPath="${FolderJava%/}/${JavaPath#/}"
    if [[ ! -f "${JavaPath#/}" ]]
    then
      echo "not found ${line}"
      continue
    fi
    echo "compiling ${line}"
    javac -d "${FolderClass%/}/" --class-path "${CLASSPATH}" "${JavaPath}"
  done


