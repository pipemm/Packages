#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

export HADOOP_HOME=$(bash get-home-hadoop.sh)

HIVE_HOME=$(bash get-home-hive.sh)
PATH="${PATH}:${HIVE_HOME%/}/bin/"

beeline --version
