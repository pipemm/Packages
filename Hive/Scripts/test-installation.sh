#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_path='../get-path-new.sh'
if [[ -f "${sh_path}" ]]
then
  PATH=$(bash "${sh_path}")
fi

##
sh_home_jre='../get-home-java-jre.sh'
if [[ -f "${sh_home_jre}" ]]
then
  JAVA_HOME_VAR=$(bash "${sh_home_jre}")
  JAVA_HOME_BIN="${JAVA_HOME_VAR%/}/bin/"
  if [[ -d "${JAVA_HOME_BIN}" ]]
  then
    PATH="${JAVA_HOME_BIN%/}:${PATH}"
  fi
fi

echo "PATH=${PATH}"

which -a java
java --version
java --help

which -a javac
javac --version
javac --help

which -a hadoop
hadoop version
hadoop --help

which -a beeline
beeline --version
beeline --help

