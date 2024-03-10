#!/bin/bash

which -a java
java --version
java --help

echo "${JAVA_HOME}"

if [ -n "${GITHUB_ENV}" ]
then
  echo "${GITHUB_ENV}"
  cat  "${GITHUB_ENV}"
fi