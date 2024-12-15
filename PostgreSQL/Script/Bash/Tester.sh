#!/usr/bin/bash

FolderClass='Class/'
FolderSDK='DevelopmentKit/'
CLASSPATH='.'
for j in ${PWD%/}/${FolderSDK%/}/*.jar
do
  CLASSPATH="$CLASSPATH:${j}"
done
CLASSPATH="$CLASSPATH:${PWD%/}/${FolderClass%/}/"

java --class-path "${CLASSPATH}" demo.Tester
