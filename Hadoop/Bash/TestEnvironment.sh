#!/usr/bin/bash

which -a which
man which

which -a bash
bash --version
bash --help

which -a curl
curl --version
curl --help

which -a sort
sort --version
sort --help

which -a cut
cut --version
cut --help

which -a java
java --version
java --help

which -a javac
javac --version
javac --help

echo "JAVA_HOME=${JAVA_HOME}"
echo "PATH=${PATH}"
