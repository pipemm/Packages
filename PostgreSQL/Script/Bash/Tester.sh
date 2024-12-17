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

java --class-path "${CLASSPATH}" demo.Tester 'Script/SQL/demo'

java --class-path "${CLASSPATH}" demo.Tester 'Script/SQL/notexists.sql'

java --class-path "${CLASSPATH}" demo.Tester 'Script/SQL/demo.sql'
