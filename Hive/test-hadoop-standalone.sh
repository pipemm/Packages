#!/usr/bin/bash

ThisScript=$(realpath "${0}")
ThisPath="${ThisScript%/*}/"
cd "${ThisPath}"

FolderInput='TestInput/'
FolderOutput='TestOutput/'

HADOOP_HOME=$(bash get-home-hadoop.sh)
PATH="${PATH}:${HADOOP_HOME%/}/bin/"

mkdir --parent "${FolderInput%/}/"
cp ${HADOOP_HOME%/}/etc/hadoop/*.xml "${FolderInput%/}/"
JAR_EXAMPLE=$(
  ls ${HADOOP_HOME%/}/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar |
  head --lines=1
)

hadoop jar "${JAR_EXAMPLE}" grep "${FolderInput%/}/" "${FolderOutput%/}/" 'dfs[a-z.]+'

echo 'Showing Input ...'
ls "${FolderInput%/}/"

echo "HADOOP_HOME=${HADOOP_HOME}"

echo 'Showing Output ...'
cat "${FolderOutput%/}/"*

