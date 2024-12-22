#!/usr/bin/bash

FolderClass='Class/'
FolderSDK='DevelopmentKit/'
CLASSPATH='.'
for j in ${PWD%/}/${FolderSDK%/}/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
CLASSPATH="$CLASSPATH:${PWD%/}/${FolderClass%/}/"

FolderOut='OutputCSV/'
mkdir --parent "${FolderOut%/}/"

java --class-path "${CLASSPATH}" demo.Tester 'Script/SQL/demo.sql' "${FolderOut%/}/"

md5sum ${FolderOut%/}/*.csv

