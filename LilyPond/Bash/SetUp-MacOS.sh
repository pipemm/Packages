#!/bin/bash

subfolder=$(
  ls -d Package/lilypond-*/bin/ |
  head -n 1
)
PATH_LILYPOND="${PWD%/}/${subfolder%/}/"
PATH="${PATH}:${PATH_LILYPOND%/}"

lilypond --version
lilypond --help

if [[ -n "${GITHUB_ENV}" ]]
then
  echo "PATH_LILYPOND=${PATH_LILYPOND}"
  echo "PATH_LILYPOND=${PATH_LILYPOND}" >> "${GITHUB_ENV}"
  echo "PATH=${PATH}"
  echo "PATH=${PATH}"                   >> "${GITHUB_ENV}"
fi
