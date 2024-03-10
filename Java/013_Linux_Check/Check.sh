#!/bin/bash

which -a java
java --version
java --help

echo "${JAVA_HOME}"

which -a java |
  while read -r line
  do
    echo "${line}"
    ls -lH "${line}"
  done
