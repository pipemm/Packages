#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_path='../get-path-new.sh'
if [[ -f "${sh_path}" ]]
then
  PATH=$(bash "${sh_path}")
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

