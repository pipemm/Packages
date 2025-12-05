#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderInput='TestInput/'
FolderOutput='TestOutput/'

HADOOP_HOME_VAR=$(bash get-home-hadoop.sh)
PATH="${PATH}:${HADOOP_HOME_VAR%/}/bin/"

mkdir --parent "${FolderInput%/}/"
cp ${HADOOP_HOME_VAR%/}/etc/hadoop/*.xml "${FolderInput%/}/"
JAR_EXAMPLE=$(
  ls ${HADOOP_HOME_VAR%/}/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar |
  head --lines=1
)

hadoop jar "${JAR_EXAMPLE}" grep "${FolderInput%/}/" "${FolderOutput%/}/" 'dfs[a-z.]+'

echo 'Showing Input ...'
ls "${FolderInput%/}/"

echo "JAR_EXAMPLE=${JAR_EXAMPLE}"

echo 'Showing Output ...'
cat "${FolderOutput%/}/"*

