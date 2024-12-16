#!/usr/bin/bash

which -a which

which -a bash
bash --version
bash --help

echo "PATH=${PATH}"
echo "JAVA_HOME=${JAVA_HOME}"

which -a javac
javac --version
javac --help
javac --help-extra

which -a java
java --version
java --help
java --help-extra

echo "JAVA_HOME=${JAVA_HOME}"
