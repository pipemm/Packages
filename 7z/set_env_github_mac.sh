#!/bin/bash

thisscript=$(readlink -f "$0")
thispath="${thisscript%/*}/"
cd "${thispath}"

folder_7z='bin7z/'
utility7z=$(ls ${folder_7z%/}/*/7z*)

if [[ -z "${utility7z}" ]]
then
  echo 'utility not found'
  echo 1
fi

PATH_7Z="${PWD}/${utility7z%/*}"

ARTIFACT_NAME="${PATH_7Z##*/}"
ARTIFACT_PATH="${PATH_7Z%/}/"

echo "ARTIFACT_NAME=${ARTIFACT_NAME}"
echo "ARTIFACT_PATH=${ARTIFACT_PATH}"

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "ARTIFACT_NAME=${ARTIFACT_NAME}" >> "${GITHUB_ENV}"
  echo "ARTIFACT_PATH=${ARTIFACT_PATH}" >> "${GITHUB_ENV}"
fi

