#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

sh_path='../get-path-new.sh'
PATH=$(bash "${sh_path}")

which -a java
java --version
hadoop --help

which -a hadoop
hadoop version
hadoop --help

which -a beeline
beeline --version
beeline --help
