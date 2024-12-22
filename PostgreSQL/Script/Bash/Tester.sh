#!/usr/bin/bash

FolderClass='Class/'
FolderSDK='DevelopmentKit/'
CLASSPATH="${FolderClass%/}/"
for j in ${PWD%/}/${FolderSDK%/}/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
FolderDepend='Dependency/'
for j in ${PWD%/}/${FolderDepend%/}/**/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
echo "${CLASSPATH}"

FolderOut='OutputCSV/'
mkdir --parent "${FolderOut%/}/"

java --class-path "${CLASSPATH}" demo.Tester 'Script/SQL/demo.sql' "${FolderOut%/}/"

md5sum ${FolderOut%/}/*.csv

